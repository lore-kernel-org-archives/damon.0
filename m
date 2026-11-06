Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930769;
	b=mavlSJpEdJiqxVaLPYNRtv3nnLlQB7WB28PgWvdOGi7YPAG05Wt2mkTAzrL9GQaoUlHF
	 xxucdzLX6K3jsZqwqN0r7YIC1WAGkxLFQP/4ORjrx4DbAk6iNca2WNGoZOwf5IGH+qn1R
	 BIbZ1k1e+TqgqB47/XkNeVxOI2m5Y2q75QfL4BzwHUkYHbIW1D8JKRbS8rfk+w+mDWVkw
	 yNM9TOMnC4O5e3508em+zG1SZIlgXtK9byiCZS9ZcEXu6x4sWxiRWNfDYtWhcn16n6hpc
	 ZHSRK6TWiV2ED1k0Z8czqQGM6qCLlrMZLLSwlzolKM++zzUIO9JxfpV/q1BdluX1AQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930769;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0n/wDrzFbORfw6YzEg6DroNWO8MgvFUslfYGWlwdzxI=;
	b=Lk7yIpHzPiv31/jROUg4YLoH1FAO6oQMngZDOm/iFHS6aMEpS8sIopJOQVL16a78VeST
	 nwGC++cBmE6Krija/IQVlilSqQ+KatuTv7PIcRsJCjJfmBbuBIosoUx7N2Dz+5WouBEQ0
	 1inqxUXDxg/lsQczrOOM1crSTgYn297BMCosNqSQKGWyc4U02Z5ipdpjWJhYN6wbBHMzo
	 d6H5rJwAGTv5QRKqppgYc/ExuqWw/Dimipx6to38hrzcVBL1i5VXrQ1Mwzhz+X9DZcV1a
	 /UwZppkkrUOjTXwx0C9I+OkJYYB5QtBhRmdgo42zK54bwdhnf3T216jAg6K3lzZoW+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tphx6Tfi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04F606A33E;
	Fri,  6 Nov 2026 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tphx6Tfi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2711F008A1;
	Fri,  6 Nov 2026 02:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930768;
	bh=0n/wDrzFbORfw6YzEg6DroNWO8MgvFUslfYGWlwdzxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tphx6Tfik8E4UtEnOk8Clt/iHUWlHE6k1PWmjL4eJTrPCPcxUwl5+3udkaPcNrUaV
	 3/z9ygt75kQexmfFkoR79CmuIg78I8JbA3mUF9OBg7TCq3NK+BdukJSyeenTWcJd0i
	 H4Z6L5acwe0egZDICo87IHlxCzsuIWcffoLi/GrVvoK9BwcVhfHRwzQGXOYZhedKQg
	 ptMN9VhvdzR+RzuMfCDNoqAgjSjnNW4ig5xRWF7eLHQaye/ax+itiZfHjT/o6PL7BQ
	 LYuErvG7amcFnH+i6tcKiMK4A1uyRZQb0h2FJTDRL/RrJosMEo2Y8Qfw67Xks8bGQ9
	 7IfNSHH0Qo95A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH 4/4] Docs/admin-guide/mm/damon/usage: update for age_ms damos core filter
Date: Thu,  5 Nov 2026 18:05:58 -0800
Message-ID: <20261106020559.98352-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106020559.98352-1-sj@kernel.org>
References: <20261106020559.98352-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added age_ms DAMOS core filter
type.  Add an explanation of how the age range for the filter can be
specified by the user.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index cc7465251bb6f..6093b1c8fbfd9 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -559,6 +559,9 @@ For ``probe_hits_wsum`` type, you can specify the minimum and maximum probe
 hits weighted sum value for the filter to ``min`` and ``max`` files,
 respectively.
 
+For ``age_ms`` type, you can specify the minimum and maximum age in
+milliseconds for the filter to ``min`` and ``max`` files, respectively.
+
 For ``memcg`` type, you can specify the memory cgroup of the interest by
 writing the path of the memory cgroup from the cgroups mount point to
 ``memcg_path`` file.  For ``addr`` type, you can specify the start and end
-- 
2.47.3
