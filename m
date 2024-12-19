Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139771AF0A0;
	Thu, 19 Dec 2024 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581041; cv=none; b=Pr8fjWsVWvIos7y1lwE88P96RDZioEHxEQ7RtVP35c8G+DSt+Ld8Mw89/kTIF3obZdCVSmKx2iHZYiwnhVC7CxqaJbtOZ8IU1FoHhwNGVqk2ggW3UWycmAmdd+0nMWFZZzUtjAQjG+T+0Jroai3O4B2PFahZveZE1+2bOo6NqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581041; c=relaxed/simple;
	bh=3O+7JbZj6xxSI8uZRXk/Ms1BG1Ir2OifGM6jxU273yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRgrCzIwr4aLpjAls3vPgPBUdUtkp+6xwWbtz8PgBncr0j5B1oy5m63PnUiefvvaq8BdQAZ0Fpti1/lxcAjs/Mm+MEUz/S8kbTvbwuUPhP7mvKYfpMU4hrDCsd4rF/43g4yfyprefjVW3qgAvL0Z+GI2F5RH9bYmgRemk6TiAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyHjZIYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyHjZIYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E52C4CED6;
	Thu, 19 Dec 2024 04:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581039;
	bh=3O+7JbZj6xxSI8uZRXk/Ms1BG1Ir2OifGM6jxU273yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyHjZIYKBbVSgEhHGsO/L49GzSrPmCAgLz3fFw3/HiFralNETAuZ/xTMhWDGJXTop
	 QBBl9+e7s1mwviBijmuPa9POKEy+exmlGwdq0d5k06jwod7XgV5Ow8/9wORT96nt+d
	 +uK75NV2pS0UsBJY4qLo1AcdejSh1io5Ii6XO8xRoaX/NCa0nvdkVdQ1wckbVsHAyl
	 49KZ+XdOZVsWih75jtrhbzfIkLTMkfttpVQ8D0NLP/d6ggynxGTd7owaTR9zwO7h6U
	 8x8ZYgu2vu84k41iryaUEfawSQ2BjIbTbTVf/bAnlEfHhk/TNhX9gCWCq5XBPoF6ZX
	 7lF4h6r8PjWbw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 18/18] Docs/ABI/damon: document per-region DAMOS filter-passed bytes stat file
Date: Wed, 18 Dec 2024 20:03:27 -0800
Message-Id: <20241219040327.61902-19-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new ABI for per-region operations set layer-handled DAMOS
filters passed bytes statistic.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 19cde386fd15..8c0acb31638b 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -430,3 +430,10 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the 'age' of a memory region that
 		corresponding DAMON-based Operation Scheme's action has tried
 		to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/sz_filter_passed
+Date:		Dec 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the size of the memory in the region
+		that passed DAMON operations layer-handled filters of the
+		scheme in bytes.
-- 
2.39.5

