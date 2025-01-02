Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48231B6CF6;
	Thu,  2 Jan 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844510; cv=none; b=E8nRu4ph2v80AoX9UMrtZZh9HlOy3ILz9hkEPVAmuRl8iDSgRN4gvbSBjmwGHfmMLMyc12IiOze0XmANuD1d0AG/gbz6o8BQsfa5ssIrNw7d+pLD13j9pLOvss72SWKr2aFCM5wKU5g/BSrWiMLSvpKBT9fXimWrl7IomTzZcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844510; c=relaxed/simple;
	bh=UnJyVIKRtYQAQG2EpBsfZO/49jup78sa4mglOLthEos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gif2RXu3lb9Be/kJJebAh/7RKQi2dQeY1gsLrxK+sg6/hViTBnvBJH76yTUqYSHu4qNokRD1UQGkg2k7zlbd2xJCyfmm1/I762KykukI6y3RPUAMEG0Abb2ZKwfHxkdilfB1oZCK7+Gf0Lyo6VKum0WjcQUWOuj2GWi4HJUuwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgEmnE9M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgEmnE9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171AAC4CEE4;
	Thu,  2 Jan 2025 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735844509;
	bh=UnJyVIKRtYQAQG2EpBsfZO/49jup78sa4mglOLthEos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgEmnE9Mp+px/eZdPFF6nYV98HWNhak7ZEWvExNSAZWSqNJz++d1+QOARODg/hjtD
	 kRyHquK5TdesMpSfbHw6gR46FsyYN+shjdMQV7QM+OFKh4qYmYkd8mKlIEV7GavxNM
	 GiGbZiLU7z70TNxyqLu/K95kYCo5HAfOOKoGDgONllRE8KZsrPUUygBRk/2+wF0fxk
	 CcmeP1z4hxLeeRyXwNaOvbr7UAPLr7M5ZlXin/3I0RHGA0EZj2RGDFAsIIzLdlb8qX
	 aA2oNPHrlxRui+fJ7FmDiqZRiZWsF1hgOjQxBJZvO7J4PO1YjhcmWuVqi1eSSMId+Y
	 PlaDp0WA9gSIg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/5] Docs/admin-guide/mm/damon/usage: fix and add missing DAMOS filter sysfs files on files hierarchy
Date: Thu,  2 Jan 2025 11:01:36 -0800
Message-Id: <20250102190138.47258-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250102190138.47258-1-sj@kernel.org>
References: <20250102190138.47258-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DAMON sysfs files hierarchy on DAMON usage document is wrong about DAMOS
filter directory.  The directory has 'memcg_path' file, but it wrongly
describes the name as 'memcg_id'.  Also the directory has 'addr_start',
'addr_end', and 'target_idx' files, but missing those.  Fix the wrong
name and add missed files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index ab343d6ac771..022f72cf5e14 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -89,7 +89,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,memcg_id,pass
+    │ │ │ │ │ │ │ │ 0/type,matching,pass,memcg_path,addr_start,addr_end,target_idx
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
-- 
2.39.5
