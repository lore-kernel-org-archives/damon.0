Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3F25228C;
	Fri, 10 Jul 2026 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643045; cv=none; b=II+lEIwY8uiyloFI9jOt16ixLH6GkKuao0VE72Mea0m4dNerdiQNuUSTYsyB6G8Dxj27dWTG5hbaaGXy187kwf/UAuieBcddXGeOOgTpetHke0KadZO3Mnzvl+1hC4z+0h9JOodvz571+eq8EZneDTAVZQTwoRX5e8DOrxzMV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643045; c=relaxed/simple;
	bh=wJvOYnu/IzvhhLERBhiEReHmfn6Ythxb4EzYa1WQKBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZWTixDRgE6G+JLWv4BsjbQzBL52CWe3/EPFfOiRfhgUuEqur5ZFjSjuKeD0+wG7Dz5QJYkUUkJz/NonmQumLXv6632Ys767cSFf8tNI/eabr2JuIHzkf0StU4K38NL78bjVl+arzEnrwIpu09FpSqRfws81Ykh0ZJ658kakhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkYSa4Iy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkYSa4Iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD931F00A3E;
	Fri, 10 Jul 2026 00:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643043;
	bh=tjxwjzI1jDT7bs2h2B+hgVQdgy3iqBX4IuJ/qCYlBQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MkYSa4Iyv4ugv/7PS5lTOfs0Zml+OVskOYO6D0FbHs9Qd81yU/33+OMYQuoVr46tn
	 tU+aEFzflx7+P8sZObAD1SCvXnZvVVsfDQwNeKkEyBL8f7ACFGRTrgGL7v61rEw0/g
	 yNlgccdptqOy8xKiwCamCjdxa9wA2nrfWuVsoLk1jdFxg/MqhpvFSzTaI8FmR9pDT9
	 0jSJT0VnqXm/HCGbs6YCeCXTS5oIfKuJ8NiPSiJB4QV9I6TM52kIAQTJRybJ8CpcD3
	 2hZoL3dyRS1eKQdUtuNCvVOx2QL2H10mzcaGFiIjAN0eZeWVE+WsJGzunbTxDCi2Gz
	 JD9SkRCrUztMw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 15/19] mm/damon/core: implement damon_has_probe_weight()
Date: Thu,  9 Jul 2026 17:23:41 -0700
Message-ID: <20260710002349.111414-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitors only data attributes when probe weights are set.
However, the function for detecting it is intentionally returning false
always.  The intention was to make changes for complete support of the
mode in a safe and incremental way.  Now all the building blocks are
made.  Complete the mode detection function so that the mode can really
start working.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 91964336ce31e..806a67d02a6e9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 
 static bool damon_has_probe_weights(struct damon_ctx *c)
 {
+	struct damon_probe *p;
+
+	damon_for_each_probe(p, c) {
+		if (p->weight)
+			return true;
+	}
 	return false;
 }
 
-- 
2.47.3
