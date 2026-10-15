Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235123CD8A4
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075565; cv=none; b=I6BorF9LPSC7QqCbsvQNy2ihmRevIm8pQeg/nSvz4ULLD7sMipLWoZBGs5CH+EpBp3Dnv7IhJp77UWcxBVzALloARstoIYMNY3ghqx0MjoPG1v/l1/ivSnTgD9/dTa5bgJgeKHucL2lw00QofMzZ6aK6utlpOeZqNWaeckDLdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075565; c=relaxed/simple;
	bh=n2eKzu35TvaEv8HyPaHxC7x3j0v0d8cIHnv6Jg8auww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID; b=sSuID+eEY/08bgIVN32JceZ1rB+foN3b2N+Wx8Rha3gFA1ZVKM/HRbz8m1IuqWrbRYDFIMmc4UFd6eaiGGC4/FPJ6y7t6ChYtqfv8yFHS6sPd5kXIQFKchAqr89Wxl4gD35c5igxNUgEapkM+mKn5JS889JSfLvovxmd3cdojuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKnXXkOP; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKnXXkOP"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac5f801d7cso519636a91.0
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075563; x=1792680363; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n2eKzu35TvaEv8HyPaHxC7x3j0v0d8cIHnv6Jg8auww=;
        b=IKnXXkOP88BYL6mE2Y2xP7q7I0++km2MsaHB2qypOf2TJ8xeHH1CNJqLFjdn1Z6Wx6
         YW4WJRwSAjO3nq+Lo1xVG0HOlVrTNvnkSY2gTsyQTx7qcUrrlyB3ASH6IKnZyDmEfJts
         KoEDmhFw2eSc3tviOO/RsBW1UNFwKmVv6PINrvPByMpLchtfa2LnB58xajTyNvqOQpP0
         w05sbVPTOgA1WFJtObsYNUHBE8ZsPurLMRni/3yyCVQOG14l4oPOOvoW73g3Za0Q/xky
         FgqLJfx7S2py6fphrjryquONa+6rokxBPg+2GlGAj58zhjlJ7E+fmgSrSTU+huvO8tcB
         yLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075563; x=1792680363;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2eKzu35TvaEv8HyPaHxC7x3j0v0d8cIHnv6Jg8auww=;
        b=Hz1wcSVf83LvOYtn6pqVLShMyewe9EmsBaGy15PNIH3zi9lJzgzkfucJRbfaoitN0Q
         CvygC4fdNl5xHBAYeoExuZS9M3ZU67MKRBWErsUvo4egnk0dkWeMhHgkx7/KVNSN0LoH
         OJ8bdcb+OjecHac79S8PgRox6dBRkjp3XObzzLYxqF7ccSJaIQkvAQ1IqBmRG+4aFsCf
         E8GVz0zdFlaYkFXn/H07Hit75cBwohaQgpRzwfFAuAo/XQu5i/Dllbn7TxQfn4qAbOt8
         1kKLu1Bbi11VsL8RY/Je7ha8K9V6SumkeItjyABsmEhQJ7s792tUCahGDolPzM8bduIx
         tHrw==
X-Forwarded-Encrypted: i=1; AKwUvBzzeYqWsd63Htg3DqCEBr4Kf4kYgaMwGJxO0PS0mADQ5z83LxQxwpY0AQrLvwC4PKcrMuQjag==@lists.linux.dev
X-Gm-Message-State: AFq9FYI7+9hiCeo2RcYvsrfAF1LbZsTCL6yu7+QyAyzDAYlMhHVPBW5s
	TBFU3gpDudesYtSmeGm83ji0WHoxmL4B4HIUf7FY6YRf4bWqofEX15un
X-Gm-Gg: AYBFou3StW7lN1c71eYOEGoHaDw5C9ac2ZIXfkKkY+zhcVrZPhjV1CeEC9oySz+x0gI
	Hyh65/7xLx5URaKGvjK+NmXdDx6cqTDMZP79jX/2VtErEz2TNEjABArBiqAhHj/Osflxff5XKeU
	XNsWeNC7Pqlmm47qyxWmhfFxMlBLAzNlXqQeKJqXQOmBFZwcGMmIcvHuuMx05OTsa9pfUHBlQYX
	xkrBJOopR6gWYjRSFtUafMAhJ1QP8L94Qsqtjl3ke8vWgF+dfikaF2G7eD3PUUOhux+Xn8/pkon
	SyY6CYSczmAvKHRG0w+iShJM7OKvXwwqDs3UxHQqLVAEZgauJ4ti/iu5tlkZZHQZ6cHRgVIye9P
	ORwcwpUqdpeGJwwv0zqHu58zg/Vss+8ItCR9Xkpt+D+y/8pJSmsRB5c0mH831AvrLOIx+4/pTee
	2yvDLGNeXn1vNFkMesPSVRHLM65TW40RoZszrADxsrbNBqBHRRw/TtUcVtufLZpi7pUG2gF9dA7
	qmGz5/azZbqngTU
X-Received: by 2002:a17:90b:35cc:b0:3ab:2737:3392 with SMTP id 98e67ed59e1d1-3ab3afce21emr16003498a91.53.1792075563236;
        Thu, 15 Oct 2026 07:46:03 -0700 (PDT)
Received: from [10.131.15.42] ([115.200.102.144])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd635cdffa5sm1393286a12.29.2026.10.15.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:46:02 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] DAMON_STAT: idle percentiles out of order on 32-bit
In-Reply-To: <20261015141319.88393-1-sj@kernel.org>
References:
 <CANOyQmHad1vamnZT12M5yPrJ69==Pt1U0+MGw6u0MuNtr-DRCw@mail.gmail.com>
 <20261015141319.88393-1-sj@kernel.org>
Date: Thu, 15 Oct 2026 22:45:01 +0800
Message-ID: <179207550140.2.6042983090152523193@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Hi SJ,

I haven't seen this affect a real workload. I found it while testing
DAMON_STAT on 32-bit.

The upper percentiles can stay at zero or keep old values. If someone
uses them to judge how much memory is cold or to choose a reclaim
threshold, they could get the wrong picture.

I'll send the fix and test results in a separate mail.

Thanks,
Aveline Noir
