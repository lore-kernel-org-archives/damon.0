Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382817;
	b=vgRQyhteUp+ICxU+7OmlmbSH6SoK1PHXz7JeBn7Gt4+hvsHDpDHb5biUEOBY9ifl+h07
	 7dH5gvOqoOaK6DQ29f5sSgEpWzzjRRmGT1TAL12Gcy1w6a2AqS1Lp1OweImCu8+wWwomM
	 UU1585y9CzfRkYqzttKWbgc+zVeAWq6OFfeSDQeQffqr1qooN/9GcoNA2Ac7KJeMe3rsL
	 VNhX/p8Z9QauN9AHtpvbOohQgSfk+d2lrFTywJLuS+dlY56d77bZVEHNWGaWGtaoAquDl
	 EdIxESe/tZnY0QFnTdP1+oY9bmM4glUS/69snOx77npxJvfkSY8NBytyJWbymdvQaCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=5sA/bJ7zlvzB4PjwB/BzIEOEcwq2h4lfsdHKluSnl6M=;
	b=5rGNBV7j3L9v1mZ12sGQYCCQAdPuv76IPP7fm8AlShbzkwLtsSeIGu44qVLPqV8SK4Ms
	 gqEIUE9sDXuNSTJz4Af8R7FJ5C2TpWs9UmI2OjK8vWP+43H4fyDGDIuzDOx9zeRI0nUIp
	 bB3GH4sQWwZTbguG7cuNTrSgOXqW5xfFjdgPqKb+UykyV4X4dldV4eKfMSnPOiIOh0wOz
	 NUAQrzgLxCv1pg8QvWi9RQnjt0Xl9+SfKr3/wwKfkJyuZKcJzobUpCzHat9WnSUHILJau
	 mtH3uqcjyL/+c5TsLWC0AVI89EekSLVcXsBE4DK4iOOcVR9vJKROB7nYNfQf3KKHQjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xAiFKv0X;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCB606A336
	for <damon@lists.linux.dev>; Wed, 11 Nov 2026 07:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFCB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xAiFKv0X
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdd9779aac8so413790a12.0
        for <damon@lists.linux.dev>; Tue, 10 Nov 2026 23:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794382816; x=1794987616; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5sA/bJ7zlvzB4PjwB/BzIEOEcwq2h4lfsdHKluSnl6M=;
        b=xAiFKv0XsLGpWqmcBRH7/MZ10QbR2982tg/SoWkgUSLzyEPc2CBufz7dUyyjZfM2Yp
         YPtwiBAhTNKMT3RtH760Ht88T9A7s253pRASETJ7elCNyZC9HLZFMa/G3ugK6y0tK8h+
         OFYNl7ioUGMm3C4gON1cvqRDotwnsTTo22TrQi9qC0TsDjTssoBjiUU8K0f5jiNlYowQ
         +Kn5STFjdm/wYhmSRW8LNfHlrS9zNdZVT2TuvASNXE73HQce/N7ROlcKthTsu5Q9fJsu
         1AXW9xK/wzDy/S2waEFZST0xJS5J6xN5Kdh5NqoBXPGkz3zswMshq5mbUCmVf3WihUmd
         Yrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794382816; x=1794987616;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5sA/bJ7zlvzB4PjwB/BzIEOEcwq2h4lfsdHKluSnl6M=;
        b=eJMXyWDqJEpu9IDT/02CXwg7HYvSZK84JisrxRMqoBz7ObjWUEPwUblSoAyH/ecA7m
         a4jbbeHmiPAlF69VbKtWxgnFJANk16O/IzzodyKkHy9QZ1svZX5derc8Nb2Y4enV6VmV
         f6w1bMB5i4/Zh5zWeKB2TPF7kanxSriCqlbU3ptjsx+iCGAcMSwu711moCDPzqSRCJus
         SlwdxjngJk0BFs5UDhfvk7CdGk0CW2VwsSZrw3lreAWVB/1gwrjOgisU9dLL9Za16VoQ
         pnR8Nm6LfkOWzl+P4NrrRVSpcU4pfUiTdLvz7H+OPiU6p/8Z+YQXUfRUvZkKcfUoExGP
         95Gg==
X-Forwarded-Encrypted: i=1; AL+hErF9W2XYAtZhBr7Es6HKnNgPUdCvTYMfEi3Nmc6GrXkTKEQQFhwo/qoKCbsZpXNSFReAf7S9Dg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8lqt1vAYNit0lGSEtS0jbL8ntgi50/gtdkvsvQpP1TVKz8gGaB
	DMjtQ1vwlCIKEKbIJVjEA0/Ryl6e8cNfHFUIJIY9YPKmHDB9frqy2rO6
X-Gm-Gg: AYBFou0aF85Z+QuQhiQWGnIyqMLzln810/7LCrWt2O7RnrFi/jxfFLdyYWkqMyJR1ze
	zUO7OEvvgcvoJg1s0y1Tky1Alof6qwt0eTf7nZH/DNLScdZ3gSq+jlaxcbw0HO2Sp3rGBq2wSE+
	6w0jDQEggYWA0CtiaMsYEPhti9adeEd0eagZFzpRickO7BqDqCbmNk3fVtvQIXXhqEWC9il2Qz7
	I70jUEoSFTi/sYfguN63UvAi+l9W87gTBh/MmUwtTxAV/qA8j1cIGg8JSBBzgKDXnnz3KiNCYPu
	tDrTEByuUrXxPs3u8cbQGkX717zTGkEb8eyDWgBNtD7SYJmELUeEfeqvhpOm7Tgpi9mj2E6Fidc
	a4/HIVZtsrsG2apPtOgYfjbjG76ijXpnXbNnjzjM8BInVFqN6tmCBrtcZk6yB+ct5QQLwTe4aGS
	3OyX9oggFt8NTmPVWNfYVwTcNBmDYxziy4je477un7V7dukSsT9+EBUADAIMWW5cM+7AgvJ+UcC
	ZyhM9/XcCJ+cZuBZfv7fEl7Fvzm5AoIWy1ZIZvOAkR2LhWUhlnEJp0pVk2nwyjizHyqo3a0S/gW
	PfESw6NnUmcYVBZCuUJNWcDoC+AaHv7HyuqXjCpkRCz7Vf6IScQAfkKB/Bq/rmpd+TLIjR/2Svg
	Zh12lAZDvZMKENo9jUAHHqExsZA==
X-Received: by 2002:a05:6a00:813:b0:89d:5a80:5256 with SMTP id d2e1a72fcca58-8bc1c59482dmr1963449b3a.9.1794382816055;
        Tue, 10 Nov 2026 23:40:16 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e110sm1781918b3a.36.2026.11.10.23.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:40:15 -0800 (PST)
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
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes
 report infra design (beyond page table accessed-bit milestone 2)
From: Aveline Noir <jm5905938@gmail.com>
Date: Wed, 11 Nov 2026 18:35:52 +1100
Message-Id: <179438255225.3134195.10613668244848761847.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261017195747.89961-1-sj@kernel.org>
References: <20261017195747.89961-1-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 17 Oct 2026 12:57:45 -0700 SJ Park wrote:

> +The data attribute probe supports the reports.  The probes can be configured to
> +hit for a given memory region depending on the existence of specific types of
> +reports that associated with the memory region in given report buffers.

I'm wondering how this would interact with the region size.  If each
page of a region is reported with probability q, a region of s pages
would hit with probability 1 - (1 - q)^s, so a large region may hit
more often than a small region of the same access density.  The page
table accessed-bit check samples one page per region, so its hit rate
doesn't depend on the region size in the same way.

A quick replay of the crediting rule of Ravi's RFC v4 [1] on synthetic
traces showed a similar trend.  The adaptive regions adjustment would
mitigate this to some extent, but large cold-only regions still kept
high hit rates after split and merge in the replay.  I'm not sure how
much it matters on real workloads, though.

Would crediting the hits relative to the region size, e.g., reported
bytes / region bytes, make sense to you?  It would need probe_hits
wider than u8, so it is not free.  If you think it is worth exploring,
I may run more experiments and share the results.

[1] https://lore.kernel.org/all/20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com/

Thanks,
Aveline Noir
