Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793673466;
	b=GnL9iNSsk5l40qUIe6xPHWGiP1IzAmBO1su9WmmbaR+WgwCVf/ZAbxFLk0Xnc+GujX33
	 oumf4VjFMPH+Lw8l0dowPJVNeGLhtnVs+XsfP/pO0k7q8PvVA3TfujTWABJFLv5JIdfmo
	 vrAuUrIiKC6hW+FuZ5Ppbe0dC164MJp266yuaCLVfOvcBzAppueuyRl4n1eYqCd40jNg0
	 g+FkMA0w9iLaPcsI9Rww8mkQIFp7GuIQCFWF5+Zq2L4DAH5l5TuHQkvva1Qm1Xu7Sc0ie
	 7NvoflAeA0WE5ecSlJaFak2PEsr/4DQ429vW+GRyGT6icTn1uytXePMtuQ6c4f+MrPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=aEZiUdHtVe6n866bPKhnP+/zTxBd9R2ODjgeXi2Z0Tk=;
	b=l2lCTbAIbaFYOL6Hz6aKDy3uETsnbFGNTQm9dw88gdGsBAifo8zd6DHiP0G8T0KNE7lq
	 7kFkTHEetOy2EEhRwCxecEwlhyhY35C6FevmGtSoBcliYaBVPR/IEqVWwylrkdLAnDetu
	 1dnHjnc84qHa/BsSfV+zUdw9awwhfxHNphpASVPokeJZOWqXzn7UnPlbsYSOEQw8H4fAA
	 nfGzUdwH1qCDerI9TFUUpVrDKUv6a7u0cMVymNrjTO/5bKKeDmpCf+aImTM/9UtbPZj3l
	 yflIdfE2tdd7j2FBrZBol2hn2556B+NGIeeV5GvCqapuxgTEm7f7fUjBleO7YzDtyRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mgiVNmQu;
	arc=fail smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F948606A326
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 02:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F948606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mgiVNmQu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53381e53b80so41327771cf.1
        for <damon@lists.linux.dev>; Mon, 02 Nov 2026 18:37:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793673465; cv=none;
        d=google.com; s=arc-20260327;
        b=NDzmNlk0WMVNDpSSRkR57OH4ywtuEP7T4JFJ8HREiB2+xCg7lhCpydL86tzbHum2LU
         N/anK2fyX/UxosXd2BAH3ORSGTuiPtXVb1kAjXwmRn0OIXOCiMS7FEELXV+S714/FtTW
         yMemfwkw8ux5u3UHT8WUkqqUkfCz1NTWkvR30/bp+hNvJbQK/0olgdFNNqfCCzJZeGol
         lBc6BWgo/JdcQcOHLHk5hkDBvuf23lG3WAgOJ/A8uShHkfP+yATQjLsEFlUyWJm8RuOz
         tjBN3tEm9MObrgWiIE+qnhjOHr4164DO5F4wbwZiSlFwcjzHze6RqPMyS8HBZG8Ig7Ub
         rsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aEZiUdHtVe6n866bPKhnP+/zTxBd9R2ODjgeXi2Z0Tk=;
        fh=tYW90Gh5KRwBiaZGtBru/nVR84kF4HdYj8cWmQUR3lc=;
        b=rfkq7+vKE8AHFaKai2yNpxbsjGNrhTxb7IGOM/DOFsB/OZJR5buKauKwCd98g72ZRy
         0hI/8df66ay4TqPpbtjnNNgOZsmBJpwnR64LA/VPjCdnQZ8pT9TNNamIfQgdgyj5zklX
         k8BmP37A1f3BRTdwwGc0mPnN61wpCLyUFgiCB4x8Iy058lKQmM7/CsqaZUHvBUXAonua
         L8lEdDeQHi/tZNy62QfXez09Du4dbjGJwYC37d6y9ARe6MZ/oEJnGWMPzpcRlO8h3CTF
         33M36/tYTFuhUmGooeTKBfozGN3Zs05Z43peDqUOqQRe8Gj/y4lKODPSQ1PMZl1wLU9G
         6KQQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793673465; x=1794278265; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aEZiUdHtVe6n866bPKhnP+/zTxBd9R2ODjgeXi2Z0Tk=;
        b=mgiVNmQusRkiYIObnoexQQUd+TQLqyvwr9A1ERKSuoWd2Hfpg5j8A3gi8mQIQ6URLu
         M9ANA8rRu2toTSLC2h/fZf5DNtZ+0V3alfF4JOBhwNUMgK7QQ1fxcj9h8tEq3/DR2hL9
         JsTuvaAJ2x2Ag/kBbFjlVA3zflUxARoCCWZ4/crHQAnblB9Rpzehc5VecSd2+rkWqATX
         MiVLF4uvnHyTuTkAHQr0jN1OZYznC5ovEgs6SXdvrsGmqG5JrISQrvToME/shvvZXB51
         3G9nXHUQvwn2OserQnkLKRJ5yhei2XnOmoAOAGKJUB6GMvmvnPT7jAMSWon3iBy/7sAw
         MOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793673465; x=1794278265;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aEZiUdHtVe6n866bPKhnP+/zTxBd9R2ODjgeXi2Z0Tk=;
        b=No+z8PnYtqhfZQHiR7Swvg3HZSDXd04WTLOpzIAzObj5rGGEihG1c2dmRw1Jr4pTap
         SYDR24faU8dtd4rWmniLBdrHXXp+80IlBgsYuhdx9owtRWiQI1RwQJ4fd2+/JtzMkGFi
         pN9IIlD9y/nbAVc9uUmJ4nfq2CUBbEiJCao9CCkq7ZryGxI+qmC3JRBlu/1gblqa5N8Q
         sP63msA+5ril3T2Zxn+t8skr6ZsL5herpvlJKaj6Hq48QTVVAD0iz6yGfCbouRzFdMt6
         +OZXnfsPnaaesswqsLwjK9xR/M8saloTAaZN8iauq2sR/o4zX7IjSpTyuh3XxrLK8Fh0
         Ks3g==
X-Forwarded-Encrypted: i=1; AKwUvBxpE1vRMrvKnypF3twb2e1vQDHJRV2A5UEnwGnlHeJVw9jdDTlBcRVbt7vSUGIb836igSi+gw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Pt6CKUzrTLr1AZ+77OUof8gFrvdKNzqYK3GlSuCWSvbuoCJ0T
	H9Dp2SfGzhzGDhpkH3JylY1/6eNi0hhD/Jz5JX4QKg2NIRubl5gF/C1QDWEqoc7/JZ6BxDANBbb
	HYblU3qjVdFGAvEXXRLUNo7WvERnkhWA=
X-Gm-Gg: AYBFou1illjGj76KU93ZqMS0ac9v60oe1/MwEgexVjeECJ9APJ5jYdsJDFZdESCVJfp
	j1IrNjzEsavKTDHj/0hNrS7yKRFqR4CTxKxPhbBJZs32HpUHtmuUTNTakVH7d2MG8VcONZjtr/Q
	5J5KZzDE/HXoMvHXMqAlhb1NWiAmX84KdlfCltE0DNuF1ZuqT2EFkTo5UYgYv5Ms9ONFfNVmRWc
	4s6DCXTWX1ZHlnLmeLc2ZcJQ4WHlunruZdmpY3mIrW64tNFcQWimH3jsEnX1voEQuMnSjq7vI4Q
	fesV2ylE5gvbuP5B0FobebDGvT7EysYWn1AHRWmNV0a/0oZoToKVY2FBXQWEY53TxZ3XzlmTikU
	hJUu8LZpo/uERL3XQsUK5iDv8krCZZEZU38FFWZeXS3Su+9KtE5oxRYCK1vAKlORDJYTXEqcxEC
	2xJ8BPjyXZcg/B9cTFt27yFhfgttNeP/EDfsvnrovpdFU7Gwv1qPb4HiLdncmhJeXgaOXRzjHmI
	GVd4dDney55nTzfBh+8c7PC0P8qMbzj1TN68OS20m2YRbU=
X-Received: by 2002:a05:622a:1b09:b0:533:a8fe:e430 with SMTP id
 d75a77b69052e-542b6593777mr202082331cf.14.1793673465209; Mon, 02 Nov 2026
 18:37:45 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261102150757.93058-1-sj@kernel.org> <20261102150757.93058-9-sj@kernel.org>
In-Reply-To: <20261102150757.93058-9-sj@kernel.org>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Mon, 2 Nov 2026 23:37:34 -0300
X-Gm-Features: AclHuK-Jg7-xraD80qWPaNaA0iIrhVFnMpsq1hNuG58d2LObr6cS1Stfw00xqhY
Message-ID: <CAMAsx6epLXuUjaV3J0=SWAuLvajr4h58DTM9gL+LMmaCyjcxUg@mail.gmail.com>
Subject: Re: [PATCH 8/9] Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye
To: manuelebnerli@mailbox.org, sj@kernel.org
Cc: corbet@lwn.net, rdunlap@infradead.org, skhan@linuxfoundation.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Manuel,

> Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye

 "stlye" -> "style"?

> Fix tenses. Split long sentences thereby imporove readability.

"imporove" -> "improve"

> +suitable to be used as a trustworthy access pattern source. These situations
> +including reclamation target page selection under sudden memory pressure.

Shouldn't this be "These situations include"? As written it is a
sentence fragment.

Thanks,
Daniel
