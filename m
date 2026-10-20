Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478805;
	b=VNElCdmVyrJqrXBJMiiN2qKMBjSkCIq7+gdr1sIWRSRbLrEU4hQIBELOZ/JIRfQ6XyCl
	 pkoy46JX0uDa9mkqovCM0B2qZz8HH+X9ZKlXE5R9e6Jqz8lecZeTanVPV//W3J9NVQHIh
	 +02cpRsHjtkhgsiHeW6VFq4Pmf0WChEGLpPFw9sMgIBHz0xizyBm9oUjH8pmF7ABuVBb2
	 S0QFbq3UziQfsMIl/Ln7cIF/e4YJbqyNihR6EQBaskbyMG5ha7GCjpoNVNVwy0KXmhtVq
	 5sWbCgkK99opuoUg7CTzVPU0TJsACVK5JVzPejv1Mo2tBpgm+AyFhqPiztgd7qAXekw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Gp9kC/jyVCXmnkxT8i7jFkbo//t/pF13KkkUzx3tMqA=;
	b=ivFGZHvgwsAKpUI/r5v4aWiRCntRhFPGJ6zB9yBEet4UiHPOXF/opefeKsNd35Vqgq2R
	 MsOdwaIMkOd4bG9yt43odUkIsJC6ppZHLiKgLWwCadamP5hbdk750ED5BnPMXvowIb86L
	 qUqEIERzIpwPYzpGmGmEQquqHoDJa8zP2MaTREKhVp8Eyeir+B5QHApr+61MV26I1d0+O
	 o4u438/AH+TmK6OCRDx9x2bes9jqRFLXlN5IXuTy2htHV0N+ytc2NaX/tl7pY0PCM/Kx+
	 F+nCSC6/5iDB1Z/XntnvxZzLIu/gWoXt/OUYGtx0QVuqhfU78/mWhyVnPBBEQOTUwFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cZN+00Tz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B26606A31B
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 06:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B26606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cZN+00Tz
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so13342195e9.1
        for <damon@lists.linux.dev>; Mon, 19 Oct 2026 23:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792478803; cv=none;
        d=google.com; s=arc-20260327;
        b=K7a28HtOBV7cxMyUlWXgy5Nmvy1dfi4TGiB8anSS5ImX8Cmzpf4+cIwR0MdQBkxaiC
         EAhRifLk5AUlbxwMo4v7xD158D5+VXA99wD3tLJD4IZJMIIH+ETUEvBHS1Rbx9EKnFn6
         9nUu9pEGFCMqHYLwwWspRVmXpjCPn49KqAfipcgSxtJDLdHJxm5dgh7VjJMzg2fb4HQ9
         HAYmE2tYwNAwc/M+ML7dVEtBzu1xyUYOBTRjUYD2Px5+SKKULYHqFjukJyZL6eNBeuA8
         MqRA06RAJB24j7motcsEbJm7l9612odp1ikLVUZAy11/0PTOds3pnPprQZ4dyzQ6P1Zi
         5JfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gp9kC/jyVCXmnkxT8i7jFkbo//t/pF13KkkUzx3tMqA=;
        fh=TNkKu0yadbFraL5pY96JZ8cSuuR631erw6u0xYp18t8=;
        b=N5qpRSuvyEJ0SXLqWaTorZ0E+WuzI0dHzQivbrHpvvSKNgQ+MRdYA+z+dUD1z/bVN/
         qFxdyLaxbY1Op3riShIUJ8fuTm4DPNiMa+Moa4jzXekAxySpcPw4TELy6SJM5y3O56RL
         hJJ/tHhjXx+acP/rn8bJsCH7LWQaUvvjH98TuJ9VKRFWf0I39+/aH4j7zb3o38KFEQxZ
         HBlvRz3BbfUMeCLEtPrUb5q81m8JfkUhp+32/3/X5qLA/gyiBCoOf6buTVJH4q0coaGN
         JXhLEfu3eZs3d7HK2N3Z6H7dsgib69e9YkVmcycHag9m1Pb01car8VxZxSHCf7POrtUX
         n45w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478803; x=1793083603; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gp9kC/jyVCXmnkxT8i7jFkbo//t/pF13KkkUzx3tMqA=;
        b=cZN+00Tz24YwfQOFiY2SCxUB+HIBGxfNEBV0KXgshZEpmdaY4QI13gJFGtCy0OEaj/
         YNcQg6oKIl52DkyjOebaYz2KjaQ+9wUVkEf0+7RTHj8OhpaSd8BeBbaFTZ4E/9p904vr
         NulHNg89ppkEgcUqE1aHgaeeAGtT4UoPC8Cck3ycd8ZINQS+fNWdABy6isa4PsOBmfqz
         h3wbOY605qXU0eric91Sq7/sS04hw4Ayp30F7lfyBJ4muthonsncgSHaqJNE3/6RfBWt
         L0dAbKIT0ZgKbbWgsrvBiNbWr380GkJ5pu3gCU3TXBopQKmDH22CSk0hZaopSJMtvsx6
         r7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478803; x=1793083603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gp9kC/jyVCXmnkxT8i7jFkbo//t/pF13KkkUzx3tMqA=;
        b=WozJ9rsh2r8W8O4KSd6thZXW5yBhaRsuGw0gbAptKl3f8QacGbCyoDXr1qO8RiQ4Dq
         Da1HsLbt5aCvtv1E+v9mRSDuyV1lbqi0eNz91/KcJgxoqMMqCN50fhe6ejHvRSHLVzSK
         Vf3VKt4tiL1n+2+/cej7vChHwVaS1LGw6LI6MfsGHr9lt5uxyETOCRF+1DxjZa5SxVVB
         7R4MAJjgu1JGeBnQ4tEiRj8TWbxaX4EKPvH5psTJoDns2rQaaFrKyhlPV0CA6Pt/jv82
         5zDgAn1kctIjK8OKmVfPfAMcyaOSGyvgkEdIsevYFfnQ3vhQ0wRiQ+ardeqZiBk7201t
         mQxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwD6iFNLailzh7ZMLH3RUQQJF2c2PoAxQaiPOHgyCl6g3B4CT7bCC1Dd0qUPAIR4u0ZN5I5ww==@lists.linux.dev
X-Gm-Message-State: AFq9FYISwzwuaxBqOmi4zprJhXdsubtuss3zZJOIPtoUHGkqbedJj2pq
	/bvNI6P5ljduF3Z307OCoI1QyuN6KrAcOQN4ylsO9bVQJrwWwwMD59b3S10YAk6nQi+q+6VYlz5
	+kaNzH6ixNDiQldyyj+aA1uzrPI642Y8=
X-Gm-Gg: AYBFou2YQzxdTwe3M9v8x3Wf5G3TaUhshnpORkXMINVdob/ugsslFlqakKa462cj0L9
	ZwtTv1T9gCuCkvveF/GqN/I2Sv4ZwvE8hvibIkMmBHGSfslUxsYUkGLX+IVpvUOmFUJdc7L8ly3
	ngo2Ni/XRPO7FcJrUhPWk2ucrgNQS6l6Rm43qADgrYKroncDpMsGXuuzofvcP/AYmgfPBwybL9F
	TVmruLxRPCukDDQG1G6v1Kw+HJFy2SCorLptfuuwP62qlNaOzdSW8mWDvUjSlHMq4dTElbem1Jh
	LkSwFufatExnAHxMu/PsBBT271dPEpIs4AjBAAknEG3ePzi0ih4zOJqEVVyavTKTuhm7zZ9NMLI
	GKnDXSgfy8bl70A==
X-Received: by 2002:a05:600c:1d05:b0:4a1:bd69:526f with SMTP id
 5b1f17b1804b1-4a1d75ab235mr196204085e9.4.1792478803164; Mon, 19 Oct 2026
 23:46:43 -0700 (PDT)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-2-0f00417b41bc@gmail.com>
 <20261004091023.630362-1-kunwu.chan@gmail.com> <CALa+Y14isN3HmsY9Mgtdi3O3zxOH33uTtajSbJcxm9FO4Uon=g@mail.gmail.com>
In-Reply-To: <CALa+Y14isN3HmsY9Mgtdi3O3zxOH33uTtajSbJcxm9FO4Uon=g@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 20 Oct 2026 14:46:32 +0800
X-Gm-Features: AclHuK_-zTMbJ1JCgYu1ZQ2d8ma027-PdiCf5iSRex2YzMdvVgiIPMhM3aQsSmk
Message-ID: <CAN_Opa_LJNTL5VwjxvWfFuC1dqNa935Aqu9fEmkCJxwOx5oNKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/9] mm/damon/core: replace the access report
 buffer with per-context rings
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, Wei Xu <weixugc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 5:11=E2=80=AFPM Ravi Jonnalagadda
<ravis.opensrc@gmail.com> wrote:
>
> >
> > Hi Ravi,
> >
> > I noticed that ring overflow drops reports and updates an
> > internal counter.
> >
> > Since hardware sampling is used as an access observation source,
> > could userspace get any indication that reports were lost during
> > an aggregation window?
>
> Hi Kunwu,
>
> Not in this RFC.  While developing the series, I used a developer-only
> commit that exposed these counters through debugfs, purely for my own
> testing; it was never meant for upstream, so the RFC keeps only the
> in-kernel accessors that the kunit tests use.  v4 [1] is the same in
> this respect.
>
> > Without such visibility, users cannot distinguish an aggregation
> > result affected by report loss from one collected without loss.
> > This may make it difficult to evaluate the reliability of the
> > observed access information.
>
> I agree that userspace should be able to see dropped reports.  Two
> things to note before exposing them: the counters are global per-CPU
> counters today, not per context, so a per-context interface needs
> per-context accounting first; and when perf throttles a source,
> samples are lost without any drop being counted.
>
> I see two options:
>
> a) a read-only file under the context or probe sysfs directory, once
>    the counters are per context, or
> b) the drop counts through a tracepoint, per aggregation window.
>
> Your PMU-agnostic observability series may be a natural home for (b).
> What do you think?
>

Thanks, Ravi. Are you referring to my earlier
'mm/damon/perf: observability framework for hardware-sampled access reports=
'
series [1]?
[1] https://lore.kernel.org/all/20260818061031.827057-1-kunwu.chan@linux.de=
v/

I developed this framework and shared it in case it might be useful to othe=
rs,
though I'm not sure whether it will eventually be merged.

The tracepoint option seems like a good fit for that work. I'll think
about it and share
any ideas I come up with.

Thanks,
Kunwu


> [1] https://lore.kernel.org/all/20261005-damon-perf-rfc-v3-send-2026-10-0=
3-v4-0-b03452e137f3@gmail.com/
>
> Thanks,
> Ravi
