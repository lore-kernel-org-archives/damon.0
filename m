Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795134806;
	b=5Moh7YRyOvm16RoO504Eib9bnSrb5yW5Ti9PmJxANjfv6q0/03NHXM1TW2CELDH07Sik
	 1noEk6T1CCtpUa5x5ayXFdck4WHshfDE/RuqB33n9TQGb1fbp+dLzjBYX6zmE8edr8lm4
	 /Ms1xHYem99myu3p2ZmIj4TU4BVhR8p/sMQK/8u/qItfIuHdtRGkAcyu72+izZdTY8YRY
	 LVX/OewWK8lDNK6+x8Wat6IDi4vxPP2Za56Avbbzqalz80EMeVWCWUpL10ya1WHekETNa
	 3pYosFnpabLqMvrsGQxt4krRxgm3+F7hvBThAnvO6/d/Kp0aBvG3c93erHo8nm7lMvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q5dwbG3U1cLtbFVF4+FubgVmvLvUVgq9jKjpGQEHC4c=;
	b=txNzL8PRN0/oHklQUoDMwmN+nwNU0XxjgOzAOd8Tuz6QTLJXBl+jDf/8KuXxKqJdbOQR
	 q9xpWXGn/JOQ1ibFYGa/1jFg4/c8iIq0FLaICIsyLEF9fERXiTxGTjWxLEASThkYDRy60
	 HSJ9W6zZsrWLrEmK2WmRv1NnSwXxRHxqxIotsoxdB4g9Eky6w6M3ikLzjhsYFTJhTctsR
	 Sje7aa3P1kgriuB2Aw3R91jXH5r/DLj8XHPpg88bzcZ516Rl9oP2sdL8NcWprQzsshADt
	 P2RW4EqyJZsfUp6X8klb+Uz0/ULR7dW1saH8L5n8PS5HR283DQ+nFOfxRIXYMoFIKPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O5ptAPBG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768E606A320
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0768E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O5ptAPBG
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so96175f8f.3
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 16:33:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795134804; cv=none;
        d=google.com; s=arc-20260327;
        b=FMIIK1dxeinaHf/jtT+W6Zgv/XiXkhiOrDrioEnq/7pyY0ly3yhUbm3XfkXa0lv9gW
         ZsO3UeDC81Pv9wZWpGYJq5s1fXf0J+fiaLTdcr0tiR/J78ciNxH+2P0GSEHir2xlnmCM
         twzbXo75qfs689QESiEI9jaS0C1w2HwRBpSiNfgE6UkhfdoAkg+M4V7u7KlK3n5AeBvv
         CWaavFB3vR5Z5Dw1cUM6oGTlrhunMeFTOIRvv/AkKlhOtYj55V87OBMODRTTY3XNXyMJ
         R0ivZlbq5ruR0C/N4Qy7sDirxl2x1ytLNA5NbZINMPdjIhAPb5t26ImeNQSC+OZ0649m
         kV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q5dwbG3U1cLtbFVF4+FubgVmvLvUVgq9jKjpGQEHC4c=;
        fh=KHx1GWxcFEMiPCtIqavYfAiNMYgvot+p51E+zye2/ZA=;
        b=qhQGoeHdugYIsJSTG4RuaaKB6w8Vv80VEdBIKHjT2UnlqP4igyDtvGvxndQ7riczMJ
         VTNXdbwJf8RFwbDFqFGKtMdxOpAQV/901Br7BarwQcfk4CE0JEWLZGHY0okDyfL2tjM0
         AJfOGpjQ4mxz5QR3s+mSfA79vpL4M0mfwyjSnnTE7h8B9fSM02jPjwEaochuhAzF2z2d
         9yiDLNNiuoCCrh+aDIPe396SslxPDxOxuLLqNe9DtSSbXYXtpOmm0kyEdFTG/UFhgog8
         mqOFOlUIEnndmq0PdxBVufOh5LIZV/rfaRwhTueOLp6V+HZmdTTyIYaT4olUZl20okyU
         VLZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795134804; x=1795739604; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5dwbG3U1cLtbFVF4+FubgVmvLvUVgq9jKjpGQEHC4c=;
        b=O5ptAPBGmgLRf9BLal7YKV4uTPTLSqAUAMNW7RgMI4ie+HPo2Wv39N00SJZQSNHLFP
         lbogqZE9wxUbzpw6ioo+eLRvZAb1qu725RSMtx2T0dMuOXwhnJqmbYLgacnsWcy752r8
         j3Ked+YrWbG5lX/9EEiVmwP0dOHHc1eBNawn7MpMX+PYQWEDf3Qg/F4AeZWy3sOojLeu
         nY3UpDo7JB/ihHUwIF9goqqVTI3/1QwoBC86ODh1XlJuwNWh7ivNBbBx0yCMhhqk+oy6
         TOYFWzPUzpNbQP2LLR0JXUcDnV5BZNgjJ3VFtJVR5O2LM7H16BLmBiaLFrVdb0OYxmRh
         Tufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134804; x=1795739604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5dwbG3U1cLtbFVF4+FubgVmvLvUVgq9jKjpGQEHC4c=;
        b=bHgGiVNYeBrfov/gL7wTWhHHsHasoyeN4AmqOBJdRPzSioqrAeFup92l6Rx/Zt9WUW
         UvjQn/kEvYWrdYu3YTuLDw815OtJaCOYGIfIQ1BTVI5hli4VTsfpFB1SHjRfz9x4F2l2
         d8nFzy6x0r9MUj1QHls5wHyPddQKkmjNaB1q2FUMTGBORikEEH49lM0cZVhJEmK0uyor
         SP4xkaq57+f/jJQTuvif7KCVsZtrPf84yPcnwH+yPeOsTY8sBFkVxMGFfPBDSnER4Wy1
         JIpMhXLZzftJPR01m3ESt1c+ZQ5aEYo0Y+IEVclsHgZ10E0GXCqFDG6ZJZICEsGoiHNP
         lY0w==
X-Forwarded-Encrypted: i=1; AL+hErHhys9GOvM5EyAiBnZ6luJqRVHMRMHf2eYoudMjt/oHGMyfwtx9A0mhcPd++Mi3kbqBkqjy0g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+mln0Vwx0ChNxklNBglZf7AeqsC44kRR8F6SDsvC+g7GsH1WsW
	+MTHV3kvtASTgcR32QnJ/q1YNaa3KttCLEoXG66YZGfHfh3I/xDm2KW6ooB1JusLvUn1ZRuPE8j
	yLQl9Qhk+D+Te/z2SiETE9yDlz+wkOpc=
X-Gm-Gg: AZFdTZfpyxs87BN3S/1SISTaQorQjs4TV7/JVlRsA5tvovn9LdtdcBm2mOG4QC36jkR
	1ibcCYoHFPGbZkjVBSfAGqoqP45ils8kVCyi94wcq+/Iwad67Xxp/ftRAll2XH/7uKnz+Cufxwk
	dD67R0m+ryO1f3ASCydy/I0lptymXRreUmXzXfQvtRKuMRBRz3JiQ7n5ZIiyRQdRRMlZlIy161i
	s09NcXUScA6/6PGvBVUCZCgeb3AF3kOjUvdZSCA2v8QKz0NUuVVAiIhOHXqNyOE5Sf5POOgHRG+
	Mgth2qoxym67HDo0/eovRMm6bcqS4Kse6VF2g70Oi4UY7d6f8/r91aJL+3dqzJnHw1E/36hhVaw
	xsSt9m+OiPPy46Wxj67o0yHbp5xAPYejAt7x8rfAN0BACcD56v6WbStB79R8Dcok0oAYFlI2N9N
	GUecF/hZDgcyaoxA/v5Pk=
X-Received: by 2002:adf:e186:0:b0:48e:20ed:d5e7 with SMTP id
 ffacd0b85a97d-4abb3a4d37dmr2109434f8f.34.1795134804351; Thu, 19 Nov 2026
 16:33:24 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
 <20261114002822.1043378-4-joannelkoong@gmail.com> <avvhF41RlOQSYFq6@chrisdown.name>
In-Reply-To: <avvhF41RlOQSYFq6@chrisdown.name>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Nov 2026 16:33:11 -0800
X-Gm-Features: Aa3M54rY2agoJDn4R2X4j9vjOezNYoLRKUGxlNrKNsn9CzkEMvge175LEU0QmY8
Message-ID: <CAJnrk1Y+QpbFhA7NZQYu_enEa9d_dp5ySL=oegeEn4SkkGE_HQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: workingset: skip the root memcg flush in workingset_test_recent()
To: Chris Down <chris@chrisdown.name>
Cc: akpm@linux-foundation.org, david@kernel.org, yosry@kernel.org, 
	mkoutny@suse.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, ljs@kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Mon, Nov 16, 2026 at 9:07=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Joanne,
>
> Joanne Koong writes:
> >-      if (flush)
> >+      if (flush && !mem_cgroup_is_root(eviction_memcg))
> >               mem_cgroup_flush_stats_ratelimited(eviction_memcg);
>
> Not a big deal, but in the v2 thread you mentioned you would try a
> mem_cgroup_flush_lru_stats_ratelimited() helper for this, per Michal's
> suggestion. That still seems like a good idea given this skip and the one=
 in
> DAMON rely on everything read after them staying in lruvec_use_node_stat(=
),
> and at least speaking for myself, keeping the root check close to the lis=
t
> in memcontrol.c makes that easier to see. It doesn't need
> to hold this patch up though, and I've tested that refaults in the root
> cgroup no longer flush, so either way:

Thanks for reviewing and testing this series. When I was updating v2
-> v3, I tested out what adding the helper looks like, but found it a
bit overkill. It adds two new api wrappers (one for ratelimited
flushes for workingset, and one for non-ratelimited flushes for
damon), each of which has only one callsite.

Maybe it would be clearest to add a comment directly at the callsites
and above lruvec_use_node_stat() to document the dependency? I'm happy
to add this in, or if you and Michal prefer the helper still, I'm
happy to add the helper APIs.

Thanks,
Joanne

>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
>
> Thanks!
>
> Chris
