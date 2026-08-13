Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FB370AE3;
	Thu, 13 Aug 2026 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593012; cv=none; b=egykkP3J+T+pyyQKOMzVYT6tUuwuHZxHHuW5xNbIsYusa5wpYurOqqRACCqu946wDLXWh/QODh8B3ped3IiFS39AsO8rgL0dk3I+POsYhsgaqBbaZu3tAfYkhJlBjdoIu9LPLs8MbhYEnp46bcB0lXFY/fhWUNpVydln9KLWG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593012; c=relaxed/simple;
	bh=mj11QH1OehidAc4GPX+bN8d559dYdSB4IO5jIUf5aNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiiDARyYiHzNa7McNt6zeQT0b0rPBdCE9zsEBzd+w6+DMFvert7W9U9BVi4vjyekxIT1G09kpaSn1q3vRjcVNaNSB/3y8Ske1n5dXMbael2BIIodGx7MLYNhTMcwEY8LHdIrK19jCiAmK/JzIr5JkW4v3HNTyTPBQh8/54AhryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJoGGSdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJoGGSdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05661F00A3D;
	Thu, 13 Aug 2026 03:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593008;
	bh=c9oXf7EAMULfNbhY5cYkXmrBshcuP/mpp00wWMiTWfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iJoGGSdGaEjb4GhhyfrN/DoXc4RJ8drILlJO9rtj/6VSiBf5E350SajVv0HD7Dsn/
	 kivaaLfRnNabpYQPi1uHU6nMutuuSvoqzhK3UieLdJb2v4whSYLf1pHgqRbXfa93mv
	 rgpFFMK25+A76cfUDRiOlFBnP+eL42WhFwclzR6QhI2VcA0Su7ANfIzoNn60XU2M9s
	 xNQ+I+bJWMBVoky87N81qfDWJ1hV4tdhdX2Dn/XyaY79wNvlioBm1tQllB643agRp1
	 EuQS5htblur55P9VnQEqKfOdOvJ8T3cKDxlboiZfngUq+6msFNHcPF5zbsVniw3rNi
	 uh0OLA851Hvjw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] mm/damon/core: handle NULL ctx parameter in damon_call()
Date: Wed, 12 Aug 2026 20:49:56 -0700
Message-ID: <20260813035001.97364-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813035001.97364-1-sj@kernel.org>
References: <20260813035001.97364-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When NULL damon_ctx pointer parameter is passed, damon_call() could do
NULL dereference.  The caller is responsible to avoid that.  It is easy
to forget, and there are many damon_call() callers.  Meanwhile,
damon_call() is never meant to be performance critical.  It uses mutex
and completion.  Add the NULL pointer check inside damon_call() so that
callers can pass the parameter without NULL checks.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 92631a36d7b51..5882f9c94c47f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2188,6 +2188,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 {
+	if (!ctx)
+		return -EINVAL;
 	if (!control->repeat)
 		init_completion(&control->completion);
 	control->canceled = false;
-- 
2.47.3
