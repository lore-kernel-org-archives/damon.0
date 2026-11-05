Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843116;
	b=bxJL1/4tqjsDavG+DwdMx8oxiV2cknI7U+VThXmJOmj+YIB7bq53cWr+2d5xM1UeeO0t
	 uVLBlBAXo4prNVrvoVdVL0R8cbJNYAcrFGgSG50+514WHO0TEgMLqhqPk4jzmig7ke9ca
	 i3HqM5Sma4OOPDbdmdITxERE0is9EZL5f/koasfSpxOCC96H98JKtD6yfeRvvxj6SEyNT
	 u9nxljDSPOjZBbMafCHoo2JayKM46emSPkXVgpr9xMcsDJVbG5rwApAhRbUEjKBEpcbA9
	 HFvlXQdpqcBbQXb98VbknZIQhKjLrYNX1/l2/YJ0RKMEMI+9kpf9E60p13I4Fsv3yLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aw1j/DMSrkeRfjbyviCP/rue4/RfxPKGIkftd8fC4p8=;
	b=p0FUgvkiZwLBquSC7bfeoBuPujVXR58ADqVeBEy1N3WlNCAaxTO+OgQUwwRzFBP0pmYC
	 HaA3DIckE19Z5oSlp6/xuBOdgHeD69JXMxTf8EnOAGpkK1j/BLJejOmlxqkMZdwoQmsI9
	 oVRdi34Qf4PYMdtvuaT3haaeiHZ+sS/edLS6hzosc7VC9AlPUbeTq+xtA0zqACg5sBnB9
	 6n9vbJansEgRod7tFRcw0Aw7dLNcNAmaPLJfquReFNQ3XgHH2USm5RAwfsxxtWbJZWpL0
	 bE6jRDwzgk5Iy2cvWaDRSfIxrUVOMa52tlxTdpsOysbrBczq0xlpBxed0EEDJmVzjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgXM5TC6;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0B606A329
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 01:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C0B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgXM5TC6
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so1187004a91.2
        for <damon@lists.linux.dev>; Wed, 04 Nov 2026 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793843116; x=1794447916; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aw1j/DMSrkeRfjbyviCP/rue4/RfxPKGIkftd8fC4p8=;
        b=hgXM5TC6nu/vrYfNZUEH/61zizt8rkZCK4NhcCbUJyECFZdLNsbnjKVVADmgpUamk3
         5K5GqviuAS6e/7wI5UrDc58uuW3bb1AKDSLRepn/y/E5pRTXdGfO4iBW4vFEhTds80Ki
         9Wv3sRRmjXGbrLfOlWn4XjZgKVqtUlwdgJq9ISGa0S0HXGsuWKt3+PZZwnsBN8CUeeje
         MgE2j6rcB6gMEjlLGnddFiVzKRLcy0wQqyY/4NeF5jwRgoXB/FuBMEEvU9kN5v1+MBPg
         PseedsQ/JswgzoiiRTan4lzblWUA2y3dV1bYBwe1GMvMBwPbxa/6h7bu7VI7/oGO/SLq
         84+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793843116; x=1794447916;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aw1j/DMSrkeRfjbyviCP/rue4/RfxPKGIkftd8fC4p8=;
        b=FGU3OOvoEYLq4wc83yYbZpodYjWHmWnoWDtKd5CIdmhAWyFqlL91wry83Z2dCfkbYi
         WYVh3Mkkz8Qs9NoyHhgLis2dm3rcVOCm+ygvcH4/Jyy3/DC/UOzxpr1VbRv5hbCRxxdl
         YwNx4YFdDs4CmarxNXH0tsu1GD+wgrpH02Cm3LJVJNcRW7iUuvCfnmiw7ya46rRuj6Mx
         cSGxHqWbHMa0+mBV1VNBrwlWZTuWUwSYyW0/JYhbPN5yuo8PZ2BBs9InOqH0zOF4WzyK
         Swp7T/GlgoPASeFhg7JcLcWEuBTAxxKv2wg9tVza4pOdTF79H8YZVwT/kcmPeSwB5h3I
         YUDg==
X-Forwarded-Encrypted: i=1; AKwUvBzqLPI9zQo6ktoNkihCig/RWuFihVgLxewqfqGmwMQs8/Iai+Di8/AWG5kncwXRK1hwXlBZYg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9J2SGAkuC+cFS3IT2diudDvNW0Y8phI8PJ5JdcpdPJTODwAgJ3
	gamdRkDaiabLAPoOd4B9a/uqiRcy5Aig2hVIq47DmqWWNBI+ulh2Zqvi
X-Gm-Gg: AYBFou3uZgw82OzeoWwl3f4MzGZI21AFgT2ZgFaWqkmzQsobfTFs2VlKceO/JKvngQo
	NPMSacxO4Btr/Dt20V/AFTYjar2OUPIMz4J939q87y5EmlQXRC+4/XfgluhkpXcCaQbzleF4d3z
	NQZnpvwakVRISVyINSgmQZ0mlLj+I97tspk9Hu+s6CHYfypViYEwj9b+tmLA6U0TArkT2W+mhK6
	YG6zz6r4sGS2UsSxrgqeYShJyuHkRtfiJv0091UougvP6zodXYA1WdtVlLTiwUVcuPmv7tsdNBe
	BLVqO5FwQJsRyWDC9KRUY1HVf2o7XA7/D4L4mv72XAjb6+OPdUyy8nae4k7dOckduGIQ6/RrDus
	eHl7Bu84MeTF/HnxbQHJN5vslqGw7YZbXpylEgDi+5R+ysQ00bXjaVeDRF69qwWhuvCR8SmxG5g
	rWiOxm1dMgvrAHLKqyhG0qgCIzrlXxiypkh9V+yVzFApRAH+Ay9AgvLfbbkQ6Q6/PBXM/WfHhWg
	McHRRAPdXp72tc0a/JCYIDjY+Aa5K2lKb/oQN/4056tcxKJS7OAauEIXjIWVjTEJZpCZuLMhhlp
	qyIdqqk6GlGUIXCd6LQ0mc5Sx3KN565XSyoAWElWutgsUnG3L6FSaAKmIreZndaFcGO0OyqaB6C
	6yogTNWb3En2RitChKWaG/0twuA==
X-Received: by 2002:a17:90b:2f08:b0:3ad:50a2:9abf with SMTP id 98e67ed59e1d1-3ae89835db3mr14659660a91.38.1793843115728;
        Wed, 04 Nov 2026 17:45:15 -0800 (PST)
Received: from [192.168.52.49] (ec2-13-158-86-59.ap-northeast-1.compute.amazonaws.com. [13.158.86.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3131f8csm1307297a91.2.2026.11.04.17.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 17:45:15 -0800 (PST)
Message-ID: <0ee661a9-b642-424f-99a1-21c9731c53aa@gmail.com>
Date: Thu, 5 Nov 2026 09:45:10 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/core: reject empty access pattern intervals on
 scheme commit
To: SJ Park <sj@kernel.org>
Cc: jm5905938@gmail.com, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, error27@gmail.com, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Liam R. Howlett" <liam@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>
References: <20261105013653.88123-1-sj@kernel.org>
From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
In-Reply-To: <20261105013653.88123-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/11/5 9:36, SJ Park 写道:
> On Wed, 4 Nov 2026 09:17:24 +0800 Wang Xiaolei <xiaoleiwangxiaolei@gmail.com> wrote:
>
>> Hi SeongJae and Aveline
>>
>>    Thank you both for the careful review.
>>
>> I appreciate the clarification that DAMON simply executes what
>>
>>    the user configured, and that this is more of an input validation
>>
>> improvement than a bug fix. Perhaps I was too aggressive in framing
>>
>> it as a bug.
> Thank you for clarifying.  But my point is that this change might be just
> unnecessary behavior change rather than an improvement.  What do you think?
Hi SeongJae

Thank you again for the clear explanation.

I agree with you . My earlier framing was wrong;

I won't push this patch further. Let me focus on the

other items that are genuine bugs instead.

thanks

xiaolei

>
>
> Thanks,
> SJ
>
> [...]
