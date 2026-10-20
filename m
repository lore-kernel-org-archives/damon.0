Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512742;
	b=GHYbrS+M4ONtTy6c5evJ16YtyHIRD+M2Jahv/1dBh4692i3DftETlHY8LLNB01Hwkkf7
	 KJHg9Gc2qtQBkBVaYbug7BwP0yxLxiAyplmb9HKZ96O5sSZb9VrhHo6YJNc0nk/lc10ql
	 Z3VOvpHpareGD7QZSMHzsf67fES//d1iNw1YRuqiebgx+ZAlWcU8O6xu6vnUuCRea389I
	 9nOUB7R4wM27sg0ntm3MhDooRwWa9F7K3ADPLQBQHYwJTaOO4SA+LefznOKWyCyMruA1y
	 KtEs+7fta/VvGuFoAyrkdxPFtvVgY/BMQQWFd/VwuHLdaj+y8n99wUv+BaPNwC723cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Message-ID:Subject:In-Reply-To:References:MIME-Version:
	 Date:Content-Type:Content-Transfer-Encoding;
	bh=Ud9ISIbyr7bf+XRYkVCQzyTUHoKhr948RmgOVkz5o0U=;
	b=e6V/VVoWS2W9yL5pMQ6A/+53XMolOFEc9eIWlJyqnn5WeumACn8gyRr7jsjPxLBOsy6X
	 qmkj0ShmU4wJXdQnA4pVCKPbkYAFVhqHGy2FaqREnj8XRIjawsOgvMkny6KwZnP9BrQfQ
	 A8oXJLH4cIyRYTsBZPqF/jxeWbuBLEylf+xtfxaELUhLtmfcukXSuefJ5ONyArK6T9KSg
	 A1L0BGnGun8/fM9x9vePe8idCUGchFfaNBYxwWTXVlvqqtfwkIGxTVuS+coJTmKBIt4e/
	 cYjYgnhfCgkFWI5l4cUQH4buEC7kLN+4qFTZf8ypClwaHSLkQtbi0hbmecFa9lft8Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WdNo2QvM;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B55606A322
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 16:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B55606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WdNo2QvM
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac6fe4aff0so2118693a91.0
        for <damon@lists.linux.dev>; Tue, 20 Oct 2026 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512742; x=1793117542; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ud9ISIbyr7bf+XRYkVCQzyTUHoKhr948RmgOVkz5o0U=;
        b=WdNo2QvMSe0zQs3DThPPOG893YhgNC0b+O6y8NnlQDuSZye9qQwdAOe2iFV8T8tzvl
         UQsU+sBYN6qxiL0MhHCKx77iJDX/2ckxN9+JjocXDExal+5rqYy8Z80fkkvvRQtQ/imE
         QBxUR7biE9VI2QxKJGtlcFKwfJ7HzDRsQ1ogegzwkeUdwHAkLXCzRVZW0/IB5RrMtVFK
         9+qDGLxGUAQuR4XsQEj+9z1slxhZOlsXzmjjUUZuk53cenP5J8X2iVcD+MZoBe3436UL
         LVCznlRjuLxZfe4QqPwL0KzdfwzpMJ0HdGxg2/IM9F3Q7hmIcEvxnj5yJwKg31QtH1hk
         f3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512742; x=1793117542;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ud9ISIbyr7bf+XRYkVCQzyTUHoKhr948RmgOVkz5o0U=;
        b=QDhenvvbeiQIMHjkMx7F00bBzcWfKs7p54qOOZUcp52sjNr3ps56lqFRJNsSMHuQlK
         T6P0sXqs/N6e9joXkUmKNM72AoBpp0YnnZaZR1ursP2dGgMruGmL7Hf1jIVHcn7SKY+Q
         sbR8F8SuxjM4N7Tmq7BYUIccoBtE+alXPBcnd4eu93/XhimxXn7dX/rFxn+uY+CnDrm4
         SktMcDa24IDGFoYym9VodtwR3rJu/OrcybfbirT7K7CE892BNuROjJc8LOfSMZU3O7eE
         xYuhUjk6XWzRlnePhKfdcerPRWdHwGzdmzXrsq0L7xdQRsrvSu3rTbWK6RF3nAwDdIt6
         6CNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJ8048Dmv/w7LhzrbztLOSO+e+mywbrVk9PUkih6WY0jbkAHDNKC5//BhOaZcRNjN3msbX0A==@lists.linux.dev
X-Gm-Message-State: AFq9FYL2Tevjc3FyQn+qdwC/zuynXbtlZ8NxF1THji2huxn5cUX3ocxS
	QDeNikGl+apta69ydgOLsiAJDqkJT39pX4QtrbebAZ10EFOIm/juW1Xj
X-Gm-Gg: AYBFou2C2iUoUo384QAoKTfxdkFP/5/89wBZH7cwGhZIpwRS6FLlWSzrU/hVAq79UeR
	dW0LhblBF79mvBKdXY/Zaox+PJZmXIV02BhB6HFOFZNGhNpKekTVk4dFJaL2z/0KE9hY9rrsyIp
	z3WjuOnf4tb9e1C33NBTc998ynxuXaIx6VGb9ZicvdKNT9WgNK9Hzhp6zXA84zVJXmrWqozEHaO
	tCMo4HUXkweyfJyjAX6nEGYT3yiFUyyeYqjp3K2d4bmLUdyxJUsUDtHAsuFIZQE3SZ+dKHUCbgY
	MsnjS2xE6R7bJgDvjUAcfOjQofkuI1pYvPZ6V3Ddk0yjR6r+V25+TTcXBKl6F5gRuuwoszgH6b2
	21UHPuFvvSJgoEYRPL78CTvilITrcbjqIz/idpitms7BHBjqal9X0VPbuad3wrS3tASzXuoLati
	sTJ6y4pJiPoRqqw8g3pEJOC0vuWDojt3yPJNDtZ2Oano5jjNW8NnKzmUP+tq+xHgc7E7bMlWGSj
	/GtqOa3EwEyVQLNFn8EeidkD091U8FddMUbr6ClOuCO1X1/o5IOeioJ1/Yx/P7fNQI1OqLcP9nO
	5bEpiSA=
X-Received: by 2002:a17:90b:51c2:b0:3a4:f75d:d1a3 with SMTP id 98e67ed59e1d1-3acef0c891cmr10365935a91.32.1792512741637;
        Tue, 20 Oct 2026 09:12:21 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80219f83sm240190a91.6.2026.10.20.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:12:21 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-ID: <179251038772.2.11838017412675823324.damon-filter@gmail.com>
Subject: Re: [PATCH] mm/damon/core: filter out damos address filter-split
 failed region
In-Reply-To: <20261020004119.106690-1-sj@kernel.org>
References: <20261020004119.106690-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 00:07:00 +0800
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi SJ,

> Filter out the entire region if the split is failed.

The Patch looks good to me. I injected -ENOMEM at both address-boundary
splits on x86-64 KVM and checked that no action was applied.
Normal-split and filter-order controls also passed.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
