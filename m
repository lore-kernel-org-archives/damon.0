Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795362214;
	b=hkdzKiQD7AgcqgckeT5xpWFA+9hHB2Hzqs6UAzZ3xRb/JU4tjWICjO6HRx435wNfqohf
	 BOIsbMWwIFOCexcyjRVzAaxkzzKMeFXEx9fVEZcS9A841u3LBF9uFVjgite8LtD2+IJlN
	 YyATTr0FkckZSm+7LFtGcRXKeWmUYnrMB2TlbaA3+xIRVIptqnyXx6CYugFlUVYd4MEb7
	 1rWDFrnc9+k/o5PVpVLLdUUgAFzp+t778n8pogpi0Js+qOL6qdYnz/9umGzGhHGsPpHTV
	 zEb58brevR5R5zBXodDsIzuKldOi0F4LPw995jZrxI/l/MJAWC9FjuCVnarQ1uyjiyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fK2KNecjm4gsbzz96uBojyVhl02omCTQXBqS1mJ9XuA=;
	b=Wagq8dr4UkM8bzjbau9CldLDBCDbNjz/+6+Wvzsk6wF4qs67TMOohGNp37ubhv502oow
	 Wq7TIhN4LFgMoKlc30QL1JSbyNMHcQuwIgoU17ILr2azPvuj7Z30swpf5YHUeamajvU3s
	 XJnL98E6ij2oMbfKZJQoO0bcOI7iveCW6eYU2+yHSg7dhq5Mh0h1LTGOIG0rVFnbSWm7K
	 wNFova3kzq5SWSqOAnmtqqRGKGVR6C2mevWDjULHgO68nm7OBOLBi5a5CrwEuL/p6KMwB
	 adiNEbW9Va7sjHkqbN7sMNBHYbkiouhj52qhk09lTbNHVC1E87MXvCGb/P79ixhewcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EvCzrSPl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C832606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 15:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C832606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EvCzrSPl
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c3bb46aaf0so683894b6e.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 07:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795362213; cv=none;
        d=google.com; s=arc-20260327;
        b=jnf+hJdkRsRAj4u4FDoGXj6ow0VnSpCEmbReh+aWwaaxf8h7KgeB2a6diLPO8R548i
         zZlpemwdmI80RW4NyyPpSU3YgAu3NCbKWmbyf9q/LPKOGcyYiwwelZS6c42P36cRFY9T
         ZhkLgrUAMvOUUSfBK/WzZLfzMbh336UHeLK3RiGx9Y6T3K9VZifoOlYo9PwJPf2qS6FX
         vvbco3EQjRqPqSv+3EUh8iQc1bPSasDbH9VY4wphk8ABSVuQofAT88hMdGR3usl6SJnT
         GKoeFKlQRnoVM2JoHVU2ZsbtS3w/e1hd9PulNKvy8WrraQdVUWppNMdpjSaohxrE7gIS
         v9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fK2KNecjm4gsbzz96uBojyVhl02omCTQXBqS1mJ9XuA=;
        fh=hHA1w8Kk+u34Q2ejd3rH7dakHtMsVqsKk7FgYJ4+E3I=;
        b=pOgYhI6myIJCeAQpXxdPD1SLy+yl5ziMczvffhqu6N6m33heKebEMgdW45gtdzelM0
         uvqarqSnP4pbjZbMbRly/dKaxsJTtu1CMt224XTVkgtdKGUUnVeVUhHO2cg2u0mmlGX7
         oVq8/YaSX4N2wXre+lYz/xDw8wbHnPJL20MVpM4QoO8fATKhG95d69ZwD20ZiL0nJ3u2
         OInowqovTAMP1pmlzgtSPzjrWEp/qQmnOaiPcZW718211WRocRTZdaCPYqghyZaY2K6O
         ZcUVgRu3OOuJ1j6KQUC5LKPYjqIJY1tOHp/HOipFm3O7lerccotUJ6W2wsGentQjqKmp
         i+Dg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795362213; x=1795967013; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fK2KNecjm4gsbzz96uBojyVhl02omCTQXBqS1mJ9XuA=;
        b=EvCzrSPlrTEAYSCa0XyAFRJ9plwGgJ3nNkWHLcAzTXf3DWtp8Cg5wh/5lLhn8GS4U6
         Ue0KL2BL3ov4R6XLl2K0RyMj9AxhlwpjMm3bjAh78jG0bKXdppwpC0VExRjL0l/Ep3Xu
         e3ca/znFVtbK336TEemARWat1x432/MxRxBrbQ//WIIufeSQXOK7smJu3TGVJeuw5d9z
         0jbRS5nO+dO1kBXAqEc0gSD+fdFwudW/9rxQwfHQUR+yjpXdqAhUC/fg8ycAGG7psHTF
         W7gWxObocxw3Q5r0cRAfYSQfeiR1m4c7fFO3CH7KVuzp29gdb4qRqVbOmBFLmvQo+dei
         M99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362213; x=1795967013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fK2KNecjm4gsbzz96uBojyVhl02omCTQXBqS1mJ9XuA=;
        b=WBiwglhQ3mK/xnBAMg7k9gVkV5JdnFo8XfCIVrSvjfZ/SGZlcwgZMjIlgetJkXLAKy
         9n9G7bDDAERCEumqHSzIISqO47h/ZwRvB0YJoEk6eHHy8yROOR1O3ZV2dOsiyOJdBiSM
         zscNNfzoKnziPpO6+hjWD7gH1ZRbEq4TIIdxgHz29uUtH02yEoXs/Qep1F5TVyMJFb/z
         ET5sM8dVrtWWuwF3fH0YpFc9UpbNguuzhQJu1FGGQpv3dPY/M7nE22A6vj71OdIWmN37
         M/EsbQUhcgdZanya7Rbjqc2YTH9S6ZGtk7d5D9VYn3CdlMogUwviD2reXXWzcAjeCYtK
         ErxA==
X-Forwarded-Encrypted: i=1; AL+hErE5eoeBLtEAAggXZA7qM+McRj7WRmEZRc/xLpLOI8yk77rhEN/zXQtXreUWtk4qS8YjvJY6Lg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9lZINCtGrHep+JsT7/laxIMAOVOWq2f+i0XkrA6kAJRxOpjW63
	OPW9QphOmWLFen/2Nm9+1jV7d0bWB7iBo2Xbbjzbvlo8y29JRNl0x9lLQn43wcjOO/XXpKB42Ve
	KpRKtIY6+VP1BUf9qjJBgJCo1nnlBfJ8=
X-Gm-Gg: AZFdTZfz3L1rTgWNTkLmICOD91TPZWavYUggjs26HTA39LTq+Za4MG6yq1RYscB44BP
	yCVedh9hVj08hu5R33RaHSkQ7LwxkEIybNlYkdLs+pUv/6QuVa6IaKnKYH3GoAGYzIBq1rxbFCT
	UhkiaFaXA6XH/wMSF0UnkgyDNwT+GH9dl20xxgWC9EbrGREuhNINRWX/rw0fEjh+LXPa1oyJ28e
	18bUk8LfHx+n6nZkRTcWavYnbKSmSYk2jBvOs5BqIDnUqw/IGY5zoZ+AonSZ20t0Psx88PUnQpZ
	NwIG5nChYDUqpgNU4rAp9d300wR88OkZCN9ie6u53EKt4s/KVAmVKEg3wfXitMep5Ps2pj5GpZS
	ARh8tVXb+UIMHtUwdgDfEKzPyUkF8eTwaVgtqSjOZUs2cVaMw2FHyESmvkjqnZpzOou2ued4Tqg
	WQqhQeraJ/iFscYhICQ7Kul9ZGMpV8
X-Received: by 2002:a05:6808:6615:b0:55c:844:9904 with SMTP id
 5614622812f47-57a0950377amr9553693b6e.17.1795362212940; Sun, 22 Nov 2026
 07:43:32 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-3-sj@kernel.org>
In-Reply-To: <20261121210013.130397-3-sj@kernel.org>
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 23 Nov 2026 02:43:18 +1100
X-Gm-Features: Aa3M54r_iVP4bVZcK2JPCcha3mQ_iDkHO1_5j6gGvQxgZFzDQ8kSC8cPoPNvnOk
Message-ID: <CANOyQmE9kM_WgOneXhQ29HTFDLYJwdzWjVKj4e11ESTtT7K2Rg@mail.gmail.com>
Subject: Re: [PATCH 02/27] mm/damon/core: implement data attribute report queue
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SJ,

On Sun, Nov 22, 2026 at 8:00=E2=80=AFAM SJ Park <sj@kernel.org> wrote:
>
> Implement DAMON core internal data structure for queuing received
> data attribute reports.  Initialize the queue for up to 1,000 reports,
> inside the DAMON init routine.  Destroy damon_region_cache and reset the
> pointer for the queue setup failures.
>

Looks good to me.

BTW, while reviewing this, I noticed a pre-existing issue in DAMON
sysfs. If the core fails to initialize, sysfs still registers the
interface, and trying to start monitoring with an initial region can
hit a NULL pointer dereference.Maybe I'll send a separate patch
to fix it.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
