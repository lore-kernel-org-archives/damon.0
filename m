Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341B539D
	for <damon@lists.linux.dev>; Sat, 16 Sep 2023 02:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFD3C433C7;
	Sat, 16 Sep 2023 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694830210;
	bh=eynGbeHbTWCoAAQx22o6QCyTrP+ceLiyJPZLaUvkSBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVF09ecmlXNA4Gm1ne2dlVGwKKBXDHM7gFSXc2cJejlIaCwBwiyeVvNwFI8Qm1Tfz
	 57C3h2zwphY3lOIm91d/nPqTyId4O9EfmA7qYlfZ9pjrLCWypmdLyaW3wq3kfx/g8W
	 Ufot/UzqKCXn8eA1oOnj4ZTfdWwtg6ZxJIY0OXbLrx84eKVr2yfBGvmHItm70EhTmB
	 t3jF1TX9mCuE5CdDmblHGw1dNK/2+9ZUjjNb3fryk2dA9h1md0SpkSkadBy1RnkSyV
	 DaY+5mNkaYiItneVpS3IfMc+s+ZRSPTYENbTucEylRX2yfN09HKustYnQbjbq8Hlga
	 PKAnbxZfPOZOQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] Docs/ABI/damon: update for DAMOS apply intervals
Date: Sat, 16 Sep 2023 02:09:45 +0000
Message-Id: <20230916020945.47296-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
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

