Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455401;
	b=zPJ66/aLypr3nyvsRRzIYvLvhnaFl+wNkB9QCslpNzXs6Psx3oqf7JWvkVIxyKkdKSfG
	 rSshGBoETgYzFiUXIwwqTpZ16WnBNFN23CnFtMsQ5JT2Wr1kgOISHufZAuIqpPmbroxI8
	 Z+U3xg7mXcnVi41JbE4n+iEhxX+5JIM3oMsPVvEgxRd0E3Bfa09OSg0FTCG/HMRIXRRTC
	 yKiyOkzGrJUmcpRwyNXBmub4D9quP89ImPn5YBM8ejQimI6AVwqgf810npKf5dqoWonuS
	 1ppimiChM1EkFMga2O6tqCJpCYyF3uE6ySDJGZ73K6/uwRl36ZAzbZ2eD/16ldfxLfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=DK0SDoEu6QZPZO8EwpxdCqNFA6Pm7zmMkL47ds9UeV4=;
	b=uTwuf5KwdGx54GMYZg9QHlpz6/Hw37yJ0Esb6NOkZa61+Pz8lXpQ92VUPWSsIs6yapTZ
	 x+Mq8w69tQ/4PI9otDi3HSPgYAnrukxHXiVRDG8YxETgp4qvxR6g0nob2ajkVw4tiNiAn
	 M9n/Xld9+sWgn5OfSYVAD/SRbJ4QaT7798fHryOw+1BrfBHWfcvJQhChG1O85YxKVavM3
	 FybQVwckdFkcA3SLblrLgQMGEpxEvZYGQ9mFft/Y+lwc0u97wjIGk9FCTvbG9wDGb4r82
	 5WEc7XIKeZXOi80x3qNpjzxPISklwGhDmf31rXsTgiWZeRz6apKoMknzOZsmMNxLD5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nj2g0NJT;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CC606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4CC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nj2g0NJT
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so670629eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455400; x=1796060200; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DK0SDoEu6QZPZO8EwpxdCqNFA6Pm7zmMkL47ds9UeV4=;
        b=nj2g0NJTSGi5Bhcmm45oCcZDUS05SALebwxM9ENeA5wA+HSWmCbzOP+Ekjf+5PueNd
         yx5okLch9DWRANzY4p7KsqxNzxAN7YAcugfx3y+/BDw9/mP81D9jwBeBR5f29NFm+Wch
         T+ECRlt4PDzJLiqYeB2S3YEVxkx9mInRDLRYcqEX79OepiaS/60bbdTsTfWf6CNfFWG1
         e1QZ7cm2ARu1IxQssuH4x8tRcryClPI4vUvdW/gjFJ3STBuh0X6qVo45M1gny+ZxmeA1
         TJnpuT7Ow0gPNBXEbgpzxa3kaCeOPpOOYnK2/4N/udxLY7HaW7c1/FYlwkeTKxavzXVd
         pDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455400; x=1796060200;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DK0SDoEu6QZPZO8EwpxdCqNFA6Pm7zmMkL47ds9UeV4=;
        b=vZB8FAkhF2/1Y1uqC3cKCWn6wI9cHSroj3p00Vs7K60Z6peiVqrLXofCBXRFpReXEH
         A5Tu4EUVV3YnBVfZuiBjNIm43dEDuZtOyvR2ToeyTL7pE+b8aJY4I4OAY8/s2+Wi7eSI
         b59JyG35h6m3tat/2mG6dQMSNcNuk61YkzVUbA678axRrRvx81Q3ixsPIolVFMxQzoLm
         rxXi7MfGnY8NLpJkJl4zztOGTfzLxU/eKCN02jP2Vs/VENs18jwcN9OavLxEUdVL8K4h
         1bQP33o/UUioadMJO8K/UHyiq2esdgJ7VDB1yomSgkp4VqQFha75sN7G6W1C1DQzP2Ps
         Nm6A==
X-Forwarded-Encrypted: i=1; AL+hErH5CqSh7fwkLtExlz9N3QRUVnRfBu3/tdCvRWgWSVk0bXBnSI4Pz/CLhkEMnELKsfcK6kdChg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/P88f4VL5BGyyei/WtHq08F+OX7jsV4WCLoYHIt1RQMpOvRulp
	sMf6iBuIXkaxYk2UpV/4ixJd/2hK4Ohf2Bl0gNJrUYnDc2rcWP+r4vIh
X-Gm-Gg: AZFdTZdAxJodpuSn8hwtc/zchN55C0ZVujU6Umk0qUOyo4xAH7w/+57YlG61K6VGh5D
	Na6qBMNmqXbgR0X6UnSVPQwZs/ZdgTFF+f4A6kX18Eoo/6S+vARTDLkj8Hq+R0aw+/wWgxUBlYG
	xMnbnwmI4i6OA9bNhSJnnhmDNMsBew2hBjUmy5+plG/6TTQg2qFAQnfv1i66ZXMdimd9z/Ugtq9
	6MKrgJUo6Qg2v7uNop4oDeFAC5XX9wBBk2WvrrSg2YI/YlqTKvzmQCy+5/zfZdh71vMUSaWRmIu
	jF039LEZwl/1+zXNS5Y2XKHnIfQrqnMMDE8RqJ+hMlJA+7exO98f/lLWCa52ELNetf/JGtSgen5
	YiSzK2ZkgbDIpOS+GN4aIieQLDdt06sijT4sZ2HrzM7zvaZRiUzjNIU1vaQgdRfhM6ivZyrRCel
	SSSEvJ8bIWlnOsNN0Gtul36FCD5qzb+YJI9ijLy0c0TEV+071eJwE0oalZ3nYJJp4s2v59UB3Yf
	018NHEvIURMmMqe2lGzyfodKIy/P1nAtrNfRB7QJMgn9BuchusAOLP2sCrO2xmTWY9dISjwc4Ws
	772cGaCLMyk0yjVjN6sn/DNafGsXOiAgotW2zU+pCU6yMeQcHKKsp/Ls4dmlsFgylzmrCxN6P1k
	3WwwviyH0h2BFX/VV+SJRS2jFCOR44mNvDqo8jmuLsS8whcMiWvW3EwsDnuz6Kg==
X-Received: by 2002:a05:693c:600a:b0:37b:4a2b:81a with SMTP id 5a478bee46e88-3863f13587fmr10922069eec.4.1795455399630;
        Mon, 23 Nov 2026 09:36:39 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:36:39 -0800 (PST)
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
Subject: Re: [PATCH 10/27] Docs/admin-guide/mm/damon/usage: update for
 report producer sysfs
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256499.4.15497978395841877294.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-doc@vger.kernel.org, 
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261121210013.130397-11-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-11-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:54 -0800 SJ Park wrote:

> Update DAMON usage document for the newly added report producer control
> sysfs files.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
