Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6C3B0583
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338098; cv=none; b=BMycZadmRPlLw29l3Kv4lcamr/txFvQ14qiu70M2ppx6hk3AN0n6z1mm/UqvYqM5icnXprUY3+LNc1kpjbZelj0ua7Ind18IKe3nT5LK5zuLoQAYCdy5QPCJ8qpdLkep03rvbaFzUrZ1RJXdbIqTTg9YVV3w+mEqYXkX4xZ4K2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338098; c=relaxed/simple;
	bh=JCVcinsThvVIH6pBjhjm7FWTCthambnHPL3kOMzJnyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2BUlSeTCLE/EE6OCSM3cwKBRqE+VSUyxfPQ5TK8yeReMSK88w5MiFYuv8j0MggnO+7yl3Is5a3txJHkQxvlmg96pviWmqCnVrzIvVTky8BJOPzMcUGPYuZDNGdoYek8mAy5uFDJOr62CaK9MVDiuUKLdXk4smplMpQxApIWvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=So8QOdRq; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="So8QOdRq"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92f03daaa97so73694585a.2
        for <damon@lists.linux.dev>; Wed, 29 Jul 2026 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785338096; x=1785942896; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2v6EYAF/prndNnQMY9/VeGyA6EcrPV2/qkncXAHToaM=;
        b=So8QOdRqgKsPKY912VleHC5WbchksSDf+DtJl8VZAdaxbtbTwPA3ZVrk8ofl5PRISh
         rs5pS7zXgN6nBopjHRlorU+OrUzMa83IkqsOWtf+0qOLtXkiOexrG0ihuKiJ6CJsvidN
         dLsswYFk+ST++kg0GXOdit5xmmXgebgFlp9pL7oaVYl6JDi/JdrfUmpQ8QmWHgcWUrDL
         GP+DAJ8Hc6B50L19kNd0cdjWxfN+tG5mbmkHft13VADJThtVKoqs9GuA3/+L4UM4RNw4
         4gUbu3V/DogXZqsdlE/miw8wvdcxF6So4Ya5zy4oAbMXBhnAaWVBpncXd9kakMW+FOAQ
         X2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338096; x=1785942896;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2v6EYAF/prndNnQMY9/VeGyA6EcrPV2/qkncXAHToaM=;
        b=Y6vhYV2vGVhnHbKifLcg8TyXtZ4/7xeH2anxJkHVrrMZgJesqnFCtXHHjBV+BHjATe
         n47h728XE5s4RIbMsxpdcfXa3AnFFgUjdIobyB73jDNr8/Kj1//s9hgBdNNUKyt7dzM2
         l8vW0iEYOh7aKGBcbAe2YPDec6alr3PX4/KNxq1tAuCzEZN8kkxHcwdUJUo06OqZom7A
         EvUy1pPTetnZv8IqyUMA4WiMVbP4QishOBfUZK/aFqe7JnLrpKPk6t5C/ZJ9tF6p05HS
         yjRPr/5KVfugBsJvBTCfjy1xIoZw6YualiNU0GHceeKeYJLMHJNJChsYr5ZXO/46aEEC
         b/xA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1/9RuOu8SbG6X6kCiYt3lQQqyQsE6Skfxkb+dBmxP0fGckT11PGvf2vjE65RbqX7p7XIcXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ+1ouzgJa0ebg9kb04bSEUKN99zzG3lN1Zmvgu0QW/6X9HdCp
	W4t+DLs8OuGFnxyJ4/02MaWleONzD8xVHJnHM2xOU3iR4QZuUwP7hmQuKmRUwiTpLa8=
X-Gm-Gg: AR+sD11G/fJrSUHDp3J7oqoEtWyJHucKWKo5N/lXvH4vI6gE8zWQlr+J74ljyUmgoFm
	tKjlhX4wPE90pxnt3cfezmJtOBGVFAhURNNX79xgN1KKFcgVvofYoG1nKH0B/95002d+wwMLiSt
	wh7wwpBLQTVp60EH2ud3e3AgEUH1wWwQ2EptO89j5g0EKe+5ep3WM0FErfd8iFPwrZodEKtYB3W
	PRRlc+ACCGowW2XdOsBrvxl5ogvs6UHo8hGYJ0tjcIqB8QRgEQGvH4Wxn1zYeSx5NZdPPoXw5sg
	K1xEoSNduQnjPAdz4cuq0SOYu4P0dBjho8/hGEfnuKKNdoCvbG2xFDSUs9jNzc+SzZlUob0F0tQ
	wQcBX3h7fPLVKavXu7p6B7XmBfHMxAqk4RYhUU9Ogp5v/DPWuZlyhT7igduW2pPYHM698lu8Rap
	bfpy1ga0WyYXNSSShVA5AnfQinwKmTmIkpjb0/cT8fbCQgdxtur0gUKfGyJzqTUsnSNRR/+Y+Ul
	99HQGccSpiZmNukQqeuOC0gS+ZZUe7fTukZKMfs/i17
X-Received: by 2002:a05:620a:6885:b0:92e:612d:87cc with SMTP id af79cd13be357-933027745b6mr659175085a.46.1785338095672;
        Wed, 29 Jul 2026 08:14:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3263c35sm187961685a.16.2026.07.29.08.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:14:55 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:14:53 -0400
From: Gregory Price <gourry@gourry.net>
To: SJ Park <sj@kernel.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	david@kernel.org, ljs@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, vbabka@kernel.org, 
	jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in
 damon_get_folio()
Message-ID: <amoXZr2vB_q5q5Wu@gourry-fedora-PF4VCD3F>
References: <amlZ_6pnt2AC-Ppl@gourry-fedora-PF4VCD3F>
 <20260729142228.88390-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729142228.88390-1-sj@kernel.org>

On Wed, Jul 29, 2026 at 07:22:28AM -0700, SJ Park wrote:
> On Tue, 28 Jul 2026 22:01:01 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> So, what do you think about adding the check under CONFIG_DAMON_DEBUG_SANITY
> with good comments at the moment, and later converting to folio_allows_mm_ops()
> together?
> 

I think probably we can drop the commit since it'll be a little odd to
add ifdef's and then take them out later (the latter check will be
functional, not just a sanity check).

~Gregory
