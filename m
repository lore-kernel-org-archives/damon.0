Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702027;
	b=XNHsXdhGlakOH6RAau1ubNfB/qcUV9cS43AmKyLI4E8D9caGed0Pas/4beMqnwdkIDId
	 StfeXa9ZfGaE3dYBUiVVdrsI/aqlgcEZqBni9henPwqLDmeteD5TLu0A6CVkjqFUp+20b
	 Tk7/Cg3DBbMC0pY0uySxQwUDUJ1JlitbdmFQ4YDeardF+iUSpFWtYpghIGNNQzQMZUsjD
	 7q+kejWKXQkB4c7Hrz9jaeFmInywT9FhZiXMpwW5/2V616vSkZq9Xcz9vNLeG3CHXkZ6z
	 1PNnJvMyWNqjCOHAq3m0U8fxFJyJGkO0FejgZJ0gt4LoHLbFe7j29nM+268D17LYvAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:Date:Message-Id:
	 To:Cc:In-Reply-To:References:X-Mailer;
	bh=BN9Z4rjr/QQvEFqoc3xGEEd37Gz2EGsQ1eWVAdfc5T0=;
	b=FfWxpewkYTrk2WHXL/LCjMQYM+ntrgHyai2tA7qPlc5prPLCIzyax4/xDmodhC4NaPHd
	 XcGfnZUydYGcECHD62tbohCs7Gmql9QU6rD5jo5WnPKfARcOeOP+FT+0aSpmy57nFzNWP
	 BkKEsUK5ry34hf82nfaVCrT2IoRaF5cAqhInw4nqmBYEgKjhBVE8y0QqjUb0p2RDLNDTZ
	 dxwb3cHb/4eXRYzAex/SF0zVnRwOovO7yetEuwApXxQJOLSsRgqgKNXNldCN3ltxzFI6p
	 sPvNJQQSPM7Y5ciTa/eKr2mp64Fts3zzpv44CExMlx4EoBobuQ7aE2NhTP5zzw054Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFvpHVAo;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88490606BF96
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 10:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88490606BF96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFvpHVAo
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e538951d07so36862435ad.0
        for <damon@lists.linux.dev>; Tue, 03 Nov 2026 02:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702027; x=1794306827; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BN9Z4rjr/QQvEFqoc3xGEEd37Gz2EGsQ1eWVAdfc5T0=;
        b=QFvpHVAoyFpD1u6ae5a25foMh6qVkunNEOnrlsZZzUsujPuQ6L7fY/JX6kZVIf3Ay+
         /HKxekAUwCp8YcI/2SUonWSVnMvr+Pfh/WVGWNKHq2U11iaRr4z7tsxjLiT6alj3ZT1v
         p63EyvBeoPuzPOdW7+qdF13QM2DTq2DGIyjyLbrBII0gXEl92TomoRKARmid5pBTFRqy
         q/TK7yRQrLs+SKVEExdLHLs7Z5GmrJ/NWc2m7ppTUMq4pjx6QKPcZWYx4fnxYvPvuypn
         YaAs0q9mhX3LJoTkmDby11uOaYjWJ5akXMoOOoHUJJwRnlpTIM5nYI4XqjFx+VFfsmMf
         chkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702027; x=1794306827;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BN9Z4rjr/QQvEFqoc3xGEEd37Gz2EGsQ1eWVAdfc5T0=;
        b=IRovUn8fdZ6zUBc1iIIZaoxWii0whuHX7OjBSfcSv+H0wXNys8kNbVnN7mxLdGsE23
         JpdCkNzaDYCw3ev/ikE+54fae+V4DoNN+DVBO5pRZL5gqptCFmuqgCPn4YUSo5tZV4jt
         430l9sjVWIcGH0/twh2+lOCDSVS9OADsVZgMIrNwkpVwXyB92KsmKMQ8WqNTPmGxAwti
         8YQP9kZupQUGMj4dSLlxpn+2E7SZfBbQXH46tKbdCCmZ49PN9DIDkkmKfAWbFZ08LiN9
         pXeDDoO3zBki9MiGPBmRzjPPH8dDa/24QsZRw7K/EEy0bWHQ+xaA+I9Q27i2dqnNXDf5
         R3uw==
X-Gm-Message-State: APuU4Z8BpszzYVwTiZ/BkpGYt2YGc2ZHJ12IdOBgXmLuvUiysuYGzUw5
	8QN/bDBfAeQXNJigoo1SN19qCl8WzmtLbVxLgO0Tf67LLE+4M6gF0gtD
X-Gm-Gg: AYBFou1QVLVFpu7P0oHAFf3rYh84CeMDTJpNaoINgn1EGlHUrIeRvwvF9xLsLMNzhZm
	o6m5aFfVkPb2OEjT9OM4qR8FDjBkqCwkewTgVh9PVIiRt8pnL7XUjK3DmTctYSDxA6EFKEbZpKA
	RucU0RfLEJ/yWasazrtqEPsEo36ImncHo/BZ/z7S4GIK3drDaYUMITF5/m4S1vT/jlfu/bO1GaD
	83mX8mUfoS14zgz87j6V9F1e0sA2EE8O/+n5vx3Qd+ChX7B4LHdyHJcekfmcacuxa0BmmbGqaGV
	LPy7FUlIMQ6DWXErw2hr6GSauDdhUEqZbi0TERp/rvdEHAZUwPT+P6dk/Z6mzKz97yd6bdGGjMW
	lO81PNEDiU+tcHVwzRXydNPWN+wmI5G2QaNJJ27JkkrR6Vg1cKT4PJ2Gu2z4Lp/V2fRKYiPaCk1
	P4NA0b9/3RvV0OviOCZTqKINUYrUGSDYtbyDlyHBQ4GfhdNqf5i+gZ9/+Ja7jDyczatHravnOh2
	/xTbDJO1sXw/gY0h0bObyZmUxywjQWz1Qn7vGalILR4tHdFvNGXEc/hoV2jlYIynaLCvOrgauAJ
	SCkVroxkYcjbMtp374848QXeHIgmj48MW5jlIPWQQMSiIOlDYpLkn19ev9gGe6L9sh9wt8saCPi
	53zJeAtXpJpIAKXzqiLLrOOTwfdo=
X-Received: by 2002:a17:903:3804:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2eb36405304mr129374835ad.5.1793702026750;
        Tue, 03 Nov 2026 02:33:46 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3928d821sm38374845ad.56.2026.11.03.02.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:33:46 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/damon/core: use list_{next,prev}_entry() in
 damon_{next,prev}_region()
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 03 Nov 2026 21:31:41 +1100
Message-Id: <179370190119.71013.18301574509097172702.b4-reply@b4>
To: Enze Li <lienze@kylinos.cn>
Cc: damon@lists.linux.dev, enze.li@gmx.com, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, sj@kernel.org
In-Reply-To: <20261103100714.70742-1-lienze@kylinos.cn>
References: <20261103100714.70742-1-lienze@kylinos.cn>
X-Mailer: b4 0.16.0

Hi Enze,

On Tue, 03 Nov 2026 18:07:14 +0800 Enze Li wrote:

> damon_next_region() and damon_prev_region() manually do container_of()
> type casting to fetch the next and previous region from the linked
> list.  Use the dedicated list.h helpers, list_next_entry() and
> list_prev_entry(), as damon_first_region() and damon_last_region() do.

The change looks correct to me.  list_{next,prev}_entry() expand to the
same container_of() calls, so there is no functional change.

That said, my understanding is that the kernel generally discourages
changes made only for coding style, outside of other work on the same
code.  Documentation/process/4.Coding.rst notes that "pure coding style
fixes are seen as noise by the development community".

SJ, what do you think about this kind of cleanup for DAMON?

Thanks,
Aveline Noir
