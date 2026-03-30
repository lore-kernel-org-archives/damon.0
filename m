Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B63C73F6
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871796; cv=none; b=rxh79Pbfrt5ZFyS2kEp5DrEkfgvtyq5a4EI7Hp/xxR5Ztw6459jemKPpPTq74qcXLVcD3CkVfVAqpHxoeAPLsD81g7Kode/4yNmqAyT2sHpE/JDs0uWEIfXj9s06krspmIKAMbYQ5KYRrXqKm+kFA6xmACwutJOHVHfHs+D9GAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871796; c=relaxed/simple;
	bh=O7tlr6zJzBi2Gn6CdZRWFdJLOKQODVVLuGaZO8WZ2H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEHky8nlhMUCiIME3+yMmNaKXqy3/YdwsPRMQuzB6+O4OG2fmdt3HdoMWBSR2ACh51/IZ06xTzeQucJG1iZAxBZiwKstmeKmkv35LES2Y9xHf9cdYXlA7USiYfLfrwefdQGFdR8xoSBY3B/mI9Sp1KhJUc1K7sCR0akvN0h3O4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NCSTrsS6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NCSTrsS6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so6204205e9.3
        for <damon@lists.linux.dev>; Mon, 30 Mar 2026 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774871794; x=1775476594; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MX3sNhAhPpZu7EQC0NlANj9qKvyIoy92fBnjmNHbYpo=;
        b=NCSTrsS6nc2ZIyr0bYcETzCIdOLuT/Z7kTQusioo14ZLQ7pKG+ZpUxaFNaRSyfDiWz
         TjgY+3qZDqzpPr158bGydfwKs0emnqTqabipDDKNvEh7/4Q2Gw+tPI0EH1D4Vzo1jupK
         jJ3950rP1LTclPIdovpmsaOMMFoHXQvkT/qDFLuppb5emaxGmS2zictD0Uv7x4PeRhqk
         fbOD59Ngc00+GRvSip331cpxRJZ85rV0473QlACysnxzgals8idSnHjy0yT38zwl5J4g
         8KEImNpBfh+Nxmyk95Wc1RMPV8jK7qLKw5Il9Ji3wWaV4EhVZ9qK/THB0X0yy7IPnkec
         vu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871794; x=1775476594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MX3sNhAhPpZu7EQC0NlANj9qKvyIoy92fBnjmNHbYpo=;
        b=A7SvFk+L1Oxd5DE6TGrpISWKS/Qn54ztWjLDLrpaT6zw4iQN71tzGsR0FYhFJferOC
         q1lviRyISV6R3J4ZcBWDBKp7hIdpD5ZAWFCdrtthlM7OPEifDV6surMc6A/PzmYK1HU6
         ZTV1kR2crOvoqJgZhuHkjP+2QS4leOB5gv3M1hqPvJopl1LRoG4yuqdQWeF3PEhyXTJp
         r7o4wM2j77y6KyzROVJgvkUGr3/fEiN75dNjfY9xnr6t1wucGIwj7VfL00BHx6Jl+kL4
         wH/S5jf567Mbnu8Mxt3u8v5PqOt8vnW0wvGBa6QA5uxWIUdX9vWO4k7ws+WSF3mzSv5V
         sntQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj/mFiptoyhKknTMjQfVpJxVEmnkTO+HP6nl7eFFjt7zZjYQ6ViblA78wUcG6lK0Td2pxLtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys4uWt9fKiRwwkqI1fKwKVvDLAAX9WFQRHhyexhiLTRxjoWZz9
	IvtRj7G9wcDS10SrGOGRgdUYlzM+6QVRAI1y1kLiSuxtbd6ZKrp+7VHZQS8APHjKr2U=
X-Gm-Gg: ATEYQzxmiYKbl8fwI7fJVvUhMnUvUBY1b7FZjEw+MXVaHzphK4B8GHg2aKtPS2+dpEx
	E6gzsk2A4tGks4fASLK0yBdIkxgdgtgZ25LjbP9JPT2DEuDKwFTGhBNIuw9I5ejk97Df/Ef1uvy
	VCawQA6gUcUryzy5W6xL74cSXSjgkYA7jJCtjnMCQyinSglDlJVPawa+6RlLuOZ61sh3jzxaqrv
	BknC8m3gm3lDa3r5k2GozZc+Attuaab4+EFZyiaRLRBOAG64oIQd7M0TuV1OZWZtuK16tWZOaPh
	2PsQHdwcj2r3o9vvNq1Rh+yQE1dLJaJjdTDM7Hulo7DNjJ4eiv6DClqamtsCQyUWo3tpbrsvLbp
	QoXJmAlwwDTkJnaxrOWX37HWYKEoMl//sNmFnaZhDb+Jot9a3BctOzkUiLvqWLuPGbJmQgnhNPf
	apMgwtbCqNdLqAsBw2P2vkONjTuGSgFOJt9IwL0QXx26Um/VJcWplfD+nIfmMXVdGPLGn0
X-Received: by 2002:a05:600c:c178:b0:486:fc61:541d with SMTP id 5b1f17b1804b1-48727ef6475mr106823855e9.2.1774871793473;
        Mon, 30 Mar 2026 04:56:33 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d40741sm287373255e9.13.2026.03.30.04.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 04:56:33 -0700 (PDT)
Message-ID: <f031418a-af79-41bb-96a9-2f88ea6ee3fd@suse.com>
Date: Mon, 30 Mar 2026 13:56:32 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering
 module
Content-Language: en-US
To: Herbert <objecting@objecting.org>, david@kernel.org
Cc: krzk@kernel.org, ljs@kernel.org, hlcj1234567@gmail.com, sj@kernel.org,
 akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 kees@kernel.org, gregkh@linuxfoundation.org, brauner@kernel.org
References: <20260326072737.341964-1-objecting@objecting.org>
 <b2cdda38-1007-41a7-a992-de953a088a08@kernel.org>
 <ae7dc7de-966e-4e04-bb55-318d97c61909@lucifer.local>
 <a9f267d5-b0a3-4118-a1c2-5caa8a3b638d@kernel.org>
 <14366e29-4ee2-490e-8e4a-0c5cace1f313@lucifer.local>
 <04B79050-4353-4FD2-A596-1474BDB94B3F@objecting.org>
 <b263a722-e9b8-4a43-a075-46e4a753871d@kernel.org>
 <043CED5F-7014-4776-824E-07E027B7BDC3@objecting.org>
 <cea99016-5407-4392-9b7d-2e6a994f550f@lucifer.local>
 <E1A667AB-DCE4-4034-A36B-DAA458780A81@objecting.org>
 <e5d45f3c-4f46-40d1-bb7a-0a2f930fd7ae@kernel.org>
 <82256A72-42FD-475E-935C-629964FA80E7@objecting.org>
 <11429699-81b4-4c1e-b247-480136fd1faf@kernel.org>
 <6deb290e-b168-4de2-95f8-fc784ed31c27@kernel.org>
 <25688dbc-cd11-4137-bad4-a215198feee6@kernel.org>
 <19d3e3d3297.190bc89f62053.5899613485100180781@objecting.org>
 <6f045727-91ff-45ea-842b-c78ea61ae4d1@kernel.org>
 <19d3e5747e1.83b0f66f64051.6129386944586321569@objecting.org>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <19d3e5747e1.83b0f66f64051.6129386944586321569@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/30/26 12:43, Herbert wrote:
>> >
>> >
>> > ? That was me learning the ropes, by making a patch to the QCOM subsystem
>> >
>> >
>> > and it was a genuinely "ok" patch.
>> >
>> >
>> > May you please tell me what I did wrong here.
>> I thought you wanted to "take a couple months break"? And I suggested
>> getting a mentor first.
> 
> Yeah, that again, was a bit stupid of me, but sorry for breaking my break, but I wanted to try doing a human patch, to see if I am capable 
> 
> 
> 
> 
>> Anyhow, this mail was sent from "Herbert", which is quite ... confusing.
> 
>  
> Changed, it was a display name for some reason.

We've heard enough of your excuses that look less and less plausible. Just
go away at this point, please.
