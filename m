Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C36187C
	for <damon@lists.linux.dev>; Sun, 10 Sep 2023 03:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF92C43395;
	Sun, 10 Sep 2023 03:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694317256;
	bh=eynGbeHbTWCoAAQx22o6QCyTrP+ceLiyJPZLaUvkSBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8Q9uAD8o9PcqFqVFXtN8GWHciJp1oKA9CHvzkSpgw2OPWsaRycMdldPI1RynQ5wX
	 n3N+eRILhlbnDGLvA8HdsQknJrO7Yo5eOR6l2ePhuVATnpcYyhgx59gEiewNFrOVaB
	 G7Xy+AuwGCx0+pXOdCLAuicPvGAqLNGAR1zzACOgQ+DBqMaRkLOWe+t7Xme9gU04WO
	 91IxlBNu0x8dHZrcbT6+TuwF2Jh7/H819njkFGH23Xml9mRdyUU0Wn7ffzt7rkujyp
	 omII1CcYj4RI/3WxnO4vlWDtMvA/Ub6lqgD1orJJPnkmG4/OlkdKgQmZPNzXEtI8zf
	 m+eV7d+nCJ4VQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 8/8] Docs/ABI/damon: update for DAMOS apply intervals
Date: Sun, 10 Sep 2023 03:40:48 +0000
Message-Id: <20230910034048.59191-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added DAMON sysfs file for DAMOS
apply intervals (apply_interval_us file).

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 420b30f09cf0..b35649a46a2f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -151,6 +151,13 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the action
 		of the scheme.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/apply_interval_us
+Date:		Sep 2023
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the action apply interval of
+		the scheme in microseconds.  Reading this file returns the
+		value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/sz/min
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.25.1

