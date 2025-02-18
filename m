Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDD1DB546;
	Tue, 18 Feb 2025 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918237; cv=none; b=DpKAdkWHdzB+TAEkGfqmaeVBtWg1/Bp3j4CzwDRiELXxW024uFc5WaORrgw1qjqghr6EwGqkqRl/XAtsZANk+bOjETVAMZK5liNgisUJZ2rcuJaOLM5kOx0QpEEsNYvYE15MeYMGQ7Ty88ImrkZ1+n9ut/x9MQc7c1x+4hJvgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918237; c=relaxed/simple;
	bh=oVrTdf5C/EBPIaqFakiqgRImT9fNI+SmRrYJWLyvJAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0/9TVWwGbW7bnrgbiVmXjTbxyhuK5/Eo0cVOJIUsUCZED9lT3EtAp3+RifPCGlaTWTbTExf5Mgzs5HjmB6Gaa0WBETHxXfSkTeBdcbty9Xx8A0/+qB+cY9RH7CXdo2IzKvRfudjqjosT+2YE1QUTUanUPQNCQpv+XvFtxYLDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWv28ne6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWv28ne6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B99C4CEE9;
	Tue, 18 Feb 2025 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918235;
	bh=oVrTdf5C/EBPIaqFakiqgRImT9fNI+SmRrYJWLyvJAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWv28ne6lJmgoEZuJmn/3XVtEE1nWDasnYx3PPO0nWlPF4XtkkXvBUfHx7r8Oyd9y
	 usAKH6EF284Tx7bGBB43hO4EcKKrGcNGj+Atk7Am8nYQ5nweYjyFgufIFsrx3N3Lv0
	 jveAIA0qL16c/YBXdLEGDjmhxdWSLztB8ch5zg08Pb2Z4gfkI65BisKvY0hWA8EgUz
	 6ehh3lHk+sWLiZsvrgGmA0oLp+l/JwauIRWQzeGQrBKzjlatB+DEUzZCwT2UlU2+VE
	 3GBgNt6lAciFyVjl1IhvOVm0yTtowBAsvpQfZroxv/Nmf1UptD4c4PtP5WHIF4+Rtn
	 fJOAlJT+C1UUA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] Docs/mm/damon/design: fix typo on DAMOS filters usage doc link
Date: Tue, 18 Feb 2025 14:37:04 -0800
Message-Id: <20250218223708.53437-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218223708.53437-1-sj@kernel.org>
References: <20250218223708.53437-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The link from DAMOS filters design doc to usage doc has a typo calling
filters as watermarks.  Fix it.

Fixes: d31f5626a0e1 ("Docs/mm/damon/design: add links to sections of DAMON sysfs interface usage doc")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e28c6a1b40ae..12ae7e1209c8 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -617,7 +617,7 @@ Below ``type`` of filters are currently supported.
     - Applied to pages that belonging to a given DAMON monitoring target.
     - Handled by the core logic.
 
-To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
+To know how user-space can set the filters via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`filters <sysfs_filters>` part of the
 documentation.
 
-- 
2.39.5
