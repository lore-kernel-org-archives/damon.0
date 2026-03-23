Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37A3859CE;
	Mon, 23 Mar 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307744; cv=none; b=IX5KUDRX/oVtgaJGLDBrewENr7lO2QvFT1Xhd8O2ZXydNuq6mrdcwpcOBP6ki3+sijZy4ROaoIQZmh/A/hVPpPfc/uX0qJH3CGU4ci+32azMyEdt2WJuaPC7Zv7HDQoqkyHxb6hP0QT4BU1Bd6tarqN9vF0Vqx/k1Lr3iLgrMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307744; c=relaxed/simple;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRmPsYAcrikf4t51vDz8Tk9bK24hqd9IG/ivPK5XoikwI0UGWrMAf3e+ZP2vQtJ6naHv77SXzBM26EbTjvxmmmlRhEk8pfsdLilJSVHclt+ruNypZ4ckarzP1x93CFhFh3VPkH9slJ0i7dxzcpmHRXf/Z1i4agrXbexOghB445k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnSjFPvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnSjFPvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E003CC2BCB5;
	Mon, 23 Mar 2026 23:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307744;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnSjFPvfAcvUf0/tfHq8Sc/28cxKBdedQrh8rBtsF+MA5bsuetvpBvO0qwRRvuycd
	 DdMT43ydffE7qwBl9caifEwjpI1i+5eKrjccPXHPG5H4N8RIbCLK0SbinAkSyov+Fb
	 851T063Zdho2vvyMHk52YbLCSfdJY026nE38oGZXYNRc66WWUp/PlwxIVH+AZfdiV/
	 mCrLfmUImz9LAGecK4HeuM+u8ce3fkoEV4g6VE4YKoSwrRu6AAbIEHjOFzI05BpyWl
	 ewFCo0N0HlqE6/nS9MF6uSXGeUl59sf4OqkiXfaGsBK04VydE6WHq7i18dKnXTj4Tx
	 xGVPwnUDrkZ4Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 05/10] Docs/ABI/damon: update for pause sysfs file
Date: Mon, 23 Mar 2026 16:15:30 -0700
Message-ID: <20260323231538.84452-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMON context execution pause/resume
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2424237ebb105..7059f540940f0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -84,6 +84,13 @@ Description:	Writing an integer to this file sets the 'address unit'
 		parameter of the given operations set of the context.  Reading
 		the file returns the last-written 'address unit' value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/pause
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a boolean keyword to this file sets the 'pause' request
+		parameter for the context.  Reading the file returns the
+		last-written 'pause' value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
