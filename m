Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794883162;
	b=LJLDXCgAAPnKaubwbYJlWVfGv3MVrR1sGfs5XUI3Q72aJ1U/tYKW7oNUeEPMHtBuQgSN
	 jmM5/D0lxeEHkU7evm7ldUK1ejabNmI1GqquQsLC4MaUEMOHq8zwyAo9XGycS4iOOdzOo
	 AIiKVkZFYKQbO/Nuc2jdNQkDabxgRKy4aJtXqZk+IVhmgYkuvd/4pEJbAIuIhgrDk/kwg
	 vGCRBcFgGsRC1mLHX3gsqhywjtjmJQgpu75HU88N951GEv8ZYYBfR4e8kjk8uUvkS3b+R
	 r7B9Z+cZer0v/CYiCk1d4ajhxYuTdsREvNb421qV+hco6RCb4ZBvUYOkY1abVTGsBnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=W3iQeyj5kHA8i7LNdw/GpSJO4XwaLwyqthlK+YVxrcY=;
	b=i7DFSMaputmdgL1uNi1lNZBUm4nbd9pTGc3wpngf/KFXNzRL7wC/wBgO1jXqj5o24M+W
	 ekGAhDXDFeCPSq/8X9BPmBWn5U11AVgfmXE11dM0qXiamGRWPkkXprWmvbnEk+jyGgcWK
	 mQ7OZiwbki3VCRXbrO6wF/kVlfA7a7XyukC7UfQD4mB2tBqJLyM18vN25Cx92bvKt7pz+
	 bU1bIzxB0+PNiONvNyNfJ8fqrIJvmAPl8+6r2SHyto/nuLe9mQMfu1z9VsM78m0uPssiy
	 QmXhNQt0/xjTjjr2hPYeJSR+SkxEVN2PrHjLLN5PQpO1+I1985blfboufWPVpvoss2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=thundercompute.com;
	spf=pass smtp.mailfrom=thundercompute.com;
	dkim=pass header.d=thundercompute.com header.i=@thundercompute.com header.a=rsa-sha256 header.s=google header.b="M/GEpM4U";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC3606A323
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 02:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CCC3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thundercompute.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundercompute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thundercompute.com header.i=@thundercompute.com header.a=rsa-sha256 header.s=google header.b=M/GEpM4U
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so5700132e87.1
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 18:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794883159; cv=none;
        d=google.com; s=arc-20260327;
        b=oIYUAveol94IV/V1c6qk+HMaNMCCnajNzwWKN+F7/WDYfXWWvFlyTsmv+gtJxMqd/i
         EK028pqy3KDvyp9Y52twnSzCyNr1sXHgC8JJNQfACx1KKXSFQa8KmcumVMQj9e4TZYqS
         q4EQFKfR96Br6gRte4oU6fvBiJe7ihYrb2D38VvoH1oKW3gCb/vWoBlL5htPouLJVGoH
         LXzt1oQHl7uRfan/a3ihvmfRISoU/YurHVfyxfSKXSVAIbiCm3pbe9vJ49LHYiUmXAmK
         /BoDxUJLXxlCMrGwVpNG6JWv5UY8rTdky21coQCYhQJJue95Fy0fdSSCVjLHrqFpHXRp
         Nn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=W3iQeyj5kHA8i7LNdw/GpSJO4XwaLwyqthlK+YVxrcY=;
        fh=kXDjzqfaIWTJ+qAqZ/Pfj+jFcLoNYqVCwgSkt4nlasg=;
        b=BipxW9aHl4rLIJ5MnicGcd1HRyD2hLQxm033rIrUiGmiu5SErOVMfzVrU0Kz4isRhy
         OiUnCYXcQxaY0GtkXCjwPmrsDG0bmUxWo52DvttxZV7t488lgaGN7vEoChpni1PxWv0n
         7fBNnPfL0OQHnlXaEyvwuRdQ5bry/N+NdPEqEf1tlVG2L3CijKlaT5yl1Ev+mFm2wkHT
         5I68gLqipj4xtrJQCXELV8kXw0xDaWcjYRWkWZGDHJYQiTqrk0vkdcbw7r7oVhu0U81f
         zHkHmwL0EObFKwXtGF+1SQhf0UsbSIJK83+61Ns5Xm1dwHa+pg4nekjxyGz0bEayFlpn
         MzYw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thundercompute.com; s=google; t=1794883159; x=1795487959; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3iQeyj5kHA8i7LNdw/GpSJO4XwaLwyqthlK+YVxrcY=;
        b=M/GEpM4UeDV/ntxVB8U+DN/vxuA2znycFCDKzu53ETdMu8kizFHQjdcVYgH99CuQDw
         x6Wgk7XUrk9S1NSjfIiNE6fE3NxpAxegemI+iHyn/4NJuctyYQwnmdqLNLgFf48zvDKi
         FM83lZKsbLi3iCd1cLbBL3EI6FbOVMdpDa6/EfCmcLYcZo33gz2HEp91EYdD1JMwL38F
         x3pOcyO5EbVFrqAnYtjuYXR4IfATvcjdz8FobomJd/ODhW+oCVspvMA6T+m5P+Ahv7Zm
         H1EzUFkenM2bfFxaenYtL/KeKNds/q/T3jqgAKayouKekV5yxEny9GX9fYU4uaAtvcGa
         wjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883159; x=1795487959;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W3iQeyj5kHA8i7LNdw/GpSJO4XwaLwyqthlK+YVxrcY=;
        b=kPMKvOMCy+ovsTpsUL2FB4CkEcGZAkFVHPnPsz0JvwO16STdLJWgBkV1DSz/kiw310
         PuQOc76hQg4oWm9/RIY6Vqw9EVl0VSBaVTZWHpfIQk1dS8pFN4/k/RCsAGxltUhnOgfI
         8ZXx5m2nuerYx01H8fFtAUB5LSigZPwpTdGabIoZoExyFc/IOC9U9sTTPnqmvCpRjSia
         vgieEhOmw/E/7b2cJkZEMNpNUgTfyiIjKCD2NhiQMgGNci4fQXScuJjhqBN96V3q52tA
         jDTps3HAxDtNZh2zJwdCm56uXgFgI87f4xLFhBnyZyZl2O6WhLD5F48/dW6IaI+K8ZqW
         VsBw==
X-Forwarded-Encrypted: i=1; AL+hErEaKZI1nSYg4lmiA1VHwLYDZekwSKGsaB6XuucpqXIzm9YexJXN8emu8PmOLMMbWXs2LAPvKA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9MlcX2r8snuD1bRhsTrq2iwx1IRV0X15M0IK8miITtYYeTmqHR
	v8vEIcPBqbAsax1t4OyQfj3ia9IQN3ZoiWS9V0rv1A4FAPq+2Tvog+GjyThDT/epl4CbjolbeTS
	EQtzvyhfhfGRz3JF/+nEfrXyTYEcLM38NbbW+t+kevQ==
X-Gm-Gg: AYBFou2NFDZKKKF84nMaWntIpooU/grIVK2vYpvpv4Bl5PKO2ZTw0Os7c9mxsPchy1y
	eFzV7i7z/q+Sg7yxKBIViY0tVk1za5a1MzoDai0gPiFUzlOrkmGOoRysJpTXMc7KZWbBAi0ocR1
	Wrw3dSMIbZKVPciH8LXqyrdywj3Uf7ljnZB/rWsNoldusjda/lhFixAzC87vYh8ikf+xzWBFclf
	vuW9hG/VH4dQumD9EldxJulJ+5wH2FGHBtZJ05egB8YtMYy8ajQ7SL9b7zDq6dFtwjLAheeUijH
	eiVjpIUgzNH1tILMEtTpGIBnvKuHpnRdlgfNxTvkJcB1AS4g0cP0YiZSsMGFaCJ58opm+5u3f06
	kM6JdqfJvCAiqfr2cz6Ps7Ddr5SgXVYsyXscegB5FV7FR795AgPYXX1X7K08BnssulG2BEMrLAB
	FLusv/yZlPeqoaMrbz1UCX+c33dMpCyEVerVhc4i6HEJN5kQf0TlqSXKDtYAnDFXfs0exGnO05v
	Nr4SonXvHzVX3vi0IE=
X-Received: by 2002:a05:6512:618a:b0:5bf:c4d2:b074 with SMTP id
 2adb3069b0e04-5c170a159camr4783685e87.55.1794883159435; Mon, 16 Nov 2026
 18:39:19 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Mark Polyakov <mark@thundercompute.com>
Date: Mon, 16 Nov 2026 18:39:08 -0800
X-Gm-Features: Aa3M54o62zRPxq-_tXfhcY6Zgma9ObTMS_OIn5JcKten7oxKU7zRiaBe3aoCxhY
Message-ID: <CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com>
Subject: Backport request for 6.12.y: mm/damon/reclaim: use parameter context correctly
To: stable@vger.kernel.org
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi, would appreciate a backport to 6.12.y of the commit
fed48693bdfeca666f7536ba88a05e9a4e5523b6 (mm/damon/reclaim: use
parameter context correctly,
https://git.kernel.org/torvalds/c/fed48693bdfeca666f7536ba88a05e9a4e5523b6).
It seems 6.12 gets backports of most DAMON fixes but this one must
have slipped through.

We've run into the issue fixed by the commit on 6.12.115: A guest VM
with DAMON_RECLAIM enabled but no reclamation occurred. After
backporting this fix ourselves, it started reclaiming.

I can provide reproducer etc if needed.

Love,
  -- Mark Polyakov
     Thunder Compute
