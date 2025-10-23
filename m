Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DA21D5BC;
	Thu, 23 Oct 2025 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182744; cv=none; b=OAE0nyGUquz/WB3+4f9b+PahxpnMj+HYJ9CVSo+aSZd0L59lRGwrXOrL1R2K8qZTnw7m30BhzIaBnXT8L11uI0bWeSv5FQ7sXngbci7pKKPRKmAXaQ30wrmOLsa5pvaO1C8Rfnrm3934U2t1dCjt9Svg5/optQYTY7BCXT8MWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182744; c=relaxed/simple;
	bh=K6zRg1CjAedGEmFhj0IW60penVdcjigiHWIj6JeYghw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttFhH9buVRG712yzO8gS7QW4v4UZFE1X0AziMDr4zyzXLCJ0dkVEuZ7yst1TKP15XMJF7qaNHfr7MbkDZC+OxXBfNHTWsFg6spRHA7Qk60++TfiS2xt/rk5i7hIZvPzcGe/S1+2Z7Y7saTFulITTSEhA/xezs/CNtbTeHzYHIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XViU0NHr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XViU0NHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A72EC4CEFF;
	Thu, 23 Oct 2025 01:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182743;
	bh=K6zRg1CjAedGEmFhj0IW60penVdcjigiHWIj6JeYghw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XViU0NHrDt1Steby8mcv0Nh3QRh9omfLt4bf6GvlSEMKV5UcVHBT2foqct9/AcxvT
	 Ck6F1pBnNSFDTpzjJ6YINcSmcKkvEMe4e43/HzQjx0DwQC19vmHy+fAy9g2wDOWxck
	 nVDrdD38tmZC6VAOzMBbsKnyeDpr5Xk8D9dbTD2UOAjREwax8jKfzOYfviPS9rwGTi
	 us3tYf9kvHaw1VqFSDvkQVIWeD+l+Ns6+RMyN/RVUUPqKYDBNUyJKQK1bRu2RviOWl
	 sCoJPmKw8icGDTEJnk7cMD2/aimYoPIXOryOwYIjs1YaEJ/wuqoqdSQJaALNgu28i4
	 LP37n2Omj8F/Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/9] Docs/ABI/damon: document obsolete_target sysfs file
Date: Wed, 22 Oct 2025 18:25:29 -0700
Message-ID: <20251023012535.69625-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
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
Reviewed-by: Bijan Tabatabai <bijan311@gmail.com>
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
