Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455554;
	b=OxocBBDmOddBSSywzjFdkmpa+yKd+HwX8LA6XiDuO/KgGL/0syeHm2keeg2TxGhFre39
	 luaUfLTzLjyje/UMRE8SgWpqP6UTveLgp0g4UOOzGjF6guwdYycOhJzu0n5SYAkHnDrBl
	 wI1HFdE/iKG4i3EjeRoK/II+MwnaqE9KKGAhL5eiO7i/52Xv+xJYNGfKznMFPv/jgtb6N
	 fI1tJYVFq5v6VY6l0PIvOe4jTR/2PV4PqK6YdSAc6ayA7FvnVsrp4C3Si2MFS6J+0y1gp
	 21Jp+DiqKag23KnqbzST1wb6YiYoUVumkc4vfvbQcQMKM/sfF7asfQjo/d1AMNkGTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=GWfgjam6rCEomOPvrn2GA2ApJi/57i65FVTDm4cSaII=;
	b=0TW+kI1/PoGWkPfuYwyTRI71MQmrprQ40N9cOb1DpQwXcEQ1izKLrIFGgKw/cGxHX0a+
	 U7cuw/tW1TBhCehYasQWPMnIE5f3poihKIFwnrtP8/EMgqECOjWbpAMDzORDsvhaTSUJT
	 2W4z/wzQSUl89hip5RVOBzZvmrcZNi9F7GuTaw+IIV81eGbxC/PzMJbU/WgvEMma1V/+q
	 idRJCzQzQc7BMueo8YC4JykPEBXg16HbmEIvW1CD7oSZ8Sv/K1VTiu7tCVVwPvINdfNQ1
	 2poFO7FD5C3iDFoJYQcOrBM+vKVNyzjrPEnLgwIVmRe54lTPUJyk4C8KerMl+X+eM/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsmILpBk;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B9606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsmILpBk
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so993616eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455553; x=1796060353; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GWfgjam6rCEomOPvrn2GA2ApJi/57i65FVTDm4cSaII=;
        b=xsmILpBkUUNNfwppqh/vjoUxB861cdYhBbtNNUbZhB7Pan2JNBMTowIbXyn+kVPy1P
         yasHgTtuJl82UJwpeLFywow9cmQtCbGpgd8aAAZSgnXvIn2p2mpIu08msdU2OyhalFht
         TdfTA5zciOPF/UDDaud/0Q4DgBNAmnicgJ+9y5jAeIIbqGjhrJSrQoMWN1er4hquR+WI
         nXr5Hd3UEm2zwvy0YunBtTBZ/eMLVbO+vIwcowjhBWo3mhDqC9W+0+t5vMABcirSpzj4
         fHJPZtPdamkIHREkmd7mIoxbf1X9hUWjxopzrDG3DP6Ph+6QF4a3W1PoEnS9oad5UAqC
         +udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455553; x=1796060353;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWfgjam6rCEomOPvrn2GA2ApJi/57i65FVTDm4cSaII=;
        b=d5W4FDJ85KbJsD8X5cIe0dwEoMRm5Pn1Y49oghibGwRJYyQi1ieu1aiIKz1mmcbUDX
         5fTSkf1SMqnqr97KaHWZ+J6aSv0Uvi0O4rHSWe453D+sj1fbSnDNBHUG6VM/fBch0lWa
         zJQmfaAoyuR6ec3YFupSU4hpdYXgwWG6/ZbY3YSz0CWuKHbHqH4Yl6fD6/4GGKxHw1Cq
         1pccIEsO1Il5EXRC2U+19S1T6Jn2ZDQmxILKjhi3DpJy1sUvmZ8RssCTo9JuW4xaJ0NO
         u6q6q/FHBu6Vp2ATPjbhXtysU/J63DNhQOLZ4jtRb4nklPaBkE0fmh0WjJY40WiC/oUL
         bKkQ==
X-Forwarded-Encrypted: i=1; AL+hErFLp90yD3vCjWLKif/Dfl/NsHjSyGO/Mbh7hmMy9+R3+nCKZWUUdF4jtHxxEcOOX+BzyGLP4w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9kAfeSKCCxMzuGGjGySJ8dkwXmMrEG+dsG2XKmfj4SBlUFb4ii
	gxTpMLOFZSD5Gv9nWXpB92uHOkD/SojfvJOXZ8ScIuq11jcR219082sq
X-Gm-Gg: AZFdTZdOuvAiaULmv1PvL72hRMDH+1OWahytfjyi9DfNrQyRwBwJ5HMP1nB3OdXbkh3
	odGLqeVtrjNPRRCmSixZpKVmuVEt+PFk+y+ppBkBYPehjvdNoDB7S+t64uRLfA/oCuIvPCpNvB1
	U1Kez5tj7iNo9fIrFPe8nZyjKRoLmJ1BoM/wG5SaKnCFql6Lyo9mypUjtFhIV5W8JCBoE3XFn0z
	n9x5d9qgKOWRaHUWCXEnEvyXhC0YabVXnEfyQprn3io//H+1I5mJZJbKdHY43WkXxr0Bi9RADd6
	JVVCrVwo3VWtKB5cVTDVE8begm6EqyvQOfDP+VCkLrVVWLj0iJtMYVEJipvffc8GVfwtuDpi21R
	TQPc6D0ih1IVrzGxuiz5JzfIkHSGg/wMJNc+Za0s1bx/F8sw6SquGVBof5jdcqPkeZek4+eWD/i
	vbSKN8RhD9NB3nfPLGvYNpvL5SuiwQEtj0H2RaT+QLqs2x8o0blMTbWUYeSt7W50B7ncc0Rj5fg
	HZ3CAeaWP2XhcpOvVPHzTvV0Zf2K1YbYYa3U29QslDBJH2utykLFAdFu3obsSAUfFCTqwaWncYN
	nNF0HCjuXWYMtum8NIf+8D0pFUT9BGoD0zymBBdi33OD5xOnSY6N2nRz4qEPOaxhhGQWe0Qtu9/
	V6x1c7RZU+x5NNfihsLp0OHLJZ+R3TnN8GMHep9bSjQYDZ0jh8Q3BAiXBILX4bw==
X-Received: by 2002:a05:693c:88d0:10b0:386:b894:f6dc with SMTP id 5a478bee46e88-386b894f8c8mr1968476eec.2.1795455552800;
        Mon, 23 Nov 2026 09:39:12 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:39:12 -0800 (PST)
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
Subject: Re: [PATCH 27/27] Docs/ABI/damon: update for user_report report
 support
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256499.4.10698731760780955093.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-28-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-28-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:11 -0800 SJ Park wrote:

> Update DAMON ABI document for the newly added user_report type data
> attribute report support.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
