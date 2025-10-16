Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955402E6100;
	Thu, 16 Oct 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651263; cv=none; b=hfUilHdAcI3q8pqfaXpVYMmgaNE4LiAwQgWKqKDRJUMSq1qEAt9sNr+RYZYs+1ub6W51dRt1dstGL8xvYJgZzMl1Ra1Csp+j4R5mHEOXQ89o02+GTngszM2348xLxnfn5as8sznV7Fdlx4c6pDD+ghpGqmBy6YjLtnpA8zUGGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651263; c=relaxed/simple;
	bh=JpqRyISZ6HQ2mzWCEY5nbQa5reQxJ9kMpl3zJAQ2NZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CD5iIoy0L73vbncalIjoT1WXHOKqJ6ExwcZxRFagRgkIBlusfYgpf5fgJZbnVNoP2bzbeS7Fsohnq85oHzhJm30QcuT4V1cuIsoGdOKBiBpwanB9ynxE4IXRkYbVO3UXrDjKMa40miA6XXM7ObBCSfaXbGAqVKVsVybVJ9HB7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZQnwU0h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZQnwU0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F577C4CEFE;
	Thu, 16 Oct 2025 21:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760651263;
	bh=JpqRyISZ6HQ2mzWCEY5nbQa5reQxJ9kMpl3zJAQ2NZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZQnwU0hG4KqVdwBF+Mm4OdnOIU1ymk6yGpSBNIucrULJbtP+oSkhJ73HOt64U7aW
	 v6uTX0bPc4qLSb4vDTPbT+Pt+cwP/2r7kcGPvzRqxZwlcBMG6KZjrx+pGJ5/nenFgf
	 otrbPDRvx26SU3z4AhzsPsOfkyobHAd/WpzydRa5ndpTOoO/IUUAHWrIKCnQRwntKB
	 ayVSHLFjKugeVTI+9hG/ZELj6ja1ZcrS5gb016wSqjb7eisXhaTZaSYKxoQgcKjC34
	 ZAlVYYw10iFj2gy3TTv5oND+GQEJY2L1eSo1FeULh/Hee8FOwWkEaFMORk1afuDkX/
	 KJqjcEu9R+6zw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	bijan311@gmail.com,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/5] Docs/ABI/damon: document obsolete_target sysfs file
Date: Thu, 16 Oct 2025 14:47:32 -0700
Message-ID: <20251016214736.84286-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016214736.84286-1-sj@kernel.org>
References: <20251016214736.84286-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added obsolete_target DAMON
sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index dce6c2cda4e8..4fb8b7a6d625 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -164,6 +164,13 @@ Description:	Writing to and reading from this file sets and gets the pid of
 		the target process if the context is for virtual address spaces
 		monitoring, respectively.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/obsolete_target
+Date:		Oct 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		obsoleteness of the matching parameters commit destination
+		target.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/nr_regions
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
