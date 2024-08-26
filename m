Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8CF6F30E;
	Mon, 26 Aug 2024 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646209; cv=none; b=resD6N9L8ufpYmESvFAXdmwP+VFC+jR5dVw88uz+g7Z3ULwG/ygURO9PAeMSqPuNPJThB2Hv9/pONLNKE1jRn5a5DHJ85qP0G6mn9DwA/Sq8A4kGpVgaQ5+swbvc0jwjl5PFxRzh/prFg1gCXSzMR5mUQx6Ih0Ilf2Dw91m6x+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646209; c=relaxed/simple;
	bh=n5ClRs5YIXQT8CMYq5oeALUYRkNDMyxAjHzrI1UVrP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kfp2MsxaEE1b7UVewwBKYxJ+qI/xDBuLJ8uvjQKsgVZhhuhlFHkBXpPkeuRW6wOX/w6gTR5Ts6t/SWHz8Non0wcn+2N9KG4Ki7DQKBpR2A3lvfyRicEvc21zw7SHQaPtZDHy3jR7wKrKy2z4brF78n5WH9/amJFM6ZnnXFxacjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su1FSJ+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su1FSJ+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61391C4AF55;
	Mon, 26 Aug 2024 04:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724646209;
	bh=n5ClRs5YIXQT8CMYq5oeALUYRkNDMyxAjHzrI1UVrP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=su1FSJ+kiS0GzuCEOWg1E6hJR1S4LhNnJ4sp+JK3RfLL+KW+mjJr0lSEFkdyouPD4
	 SxAjSLe6CNApUTwxE2wY9pSAt7LxTkVplkTBixMzP3f9FGpul3/0Jx4iS6YWuUiI90
	 QXKZTZAnEcbmbnXOSLjEyqrsJPQicwV/70w/V0S5e4CkwTO8HAn7D/TjJ8FYUdvibi
	 14nTMIXIIaIMLgwpATQcOJ6QC1qhLL3treWUkN9FIhGrcUzLOwXGiIOUIRJs+E5YbX
	 hMHZq60WD3vH38VBrk1f5tSSQG/S/9Cxv7NTMwu6VdYqb5f0SY5KtYhiLNWI+bDNv3
	 uekw/S9J2ivBQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm/damon/core: remove per-scheme region priority histogram buffer
Date: Sun, 25 Aug 2024 21:23:22 -0700
Message-Id: <20240826042323.87025-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826042323.87025-1-sj@kernel.org>
References: <20240826042323.87025-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody is reading from or writing to the per-scheme region priorities
histogram buffer.  It is only wasting memory.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6342d8f9b0fd..0ac8b862bdcb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -242,7 +242,6 @@ struct damos_quota {
 	unsigned long charge_addr_from;
 
 	/* For prioritization */
-	unsigned long histogram[DAMOS_MAX_SCORE + 1];
 	unsigned int min_score;
 
 	/* For feedback loop */
-- 
2.39.2

