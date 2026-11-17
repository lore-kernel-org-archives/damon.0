Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892062;
	b=V8zYGOGRCHRwG3immzRQJj6ZeEx9eWof6jCReQPep5pP+Dg7U2F2smdp5rcHgTwTonGi
	 BKvnZdZsU0xxbpGbhtdSwIDup1OCnhGBCHSWfg76mQhQQi2qB2HJiwHGdAsmeU1VgSgMJ
	 PAsuN25hKZ/svmR71wGatGNw84aenypbCWVoSnKT+FpsowN3W14gdnVIG0NQDQLhEwm23
	 EaWHhtlByRJC1sfbjOPM1TOkIEzPKUakedZJKnyP+BQa2drsUZJ70ZURoLJxBPwAbVRvt
	 tKpMN6TQY/H8ceUEhoU5rUPdEbFcbLz1YqTUbZ5LaY1TuiATnwnguYgtW6lGc660q8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=erZtH4IJMudy7WQUbT7BdWCH9j2OmGrPuCsVrI+Funw=;
	b=R/hGV9gVqYii/VM6/kfUWbOTJDvPZP9a9fnxKaqeObkTrbEBv8urbk0E21sZp1jE2yU4
	 nO4gdWrcvH4ZiCqdZghIy5bP5/CC9A3i6fUF30Ukmfdf3qpbfNM24Z7qv1cmqfuOiKM4/
	 wC6ylIWD8q+k0cxDA3OlxG88aJENt8aEKNn6OG4H51elBt2VVh+SNyA+EXxQ0Ny3+ZBx9
	 mhKaT6ZaPf8PoRat8D+RvjdFa0uh0g1feRt+flfnARAB3P0416pwRIrcGx/1mlhd66l6G
	 8M0TU4eFfP5uX/jBtw1uvAuxD4A1fHAUWbqAVGwFZDGFjS8W8iYKACPJkL10+tkRcHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=pm5BeLNu;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC0606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 05:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79CC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=pm5BeLNu
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38133db970bso921213eec.0
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 21:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794892062; x=1795496862; darn=lists.linux.dev;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=erZtH4IJMudy7WQUbT7BdWCH9j2OmGrPuCsVrI+Funw=;
        b=pm5BeLNusLGeuJJF5SVBhgweEOPmoAJUlU0imYjMgPymvQc2kws+e3H1970H4ef16M
         oMOlRyaJDbZyMz+EjuiUN0kbGDOYeMml7l02RfUJftXX14SrrJtSIuDkfWcZULxAhMmM
         5uJuFB6MHAQdrMZsrqZ/pZ1zMpw+wHxPhDkYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892062; x=1795496862;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erZtH4IJMudy7WQUbT7BdWCH9j2OmGrPuCsVrI+Funw=;
        b=2W19vDD1sJGRdCIOIhv8toRK34FTOgzpN7U7VxCYdX31p8udzgY0Ml+QeifzIgEMfW
         ibKUWQeJhQ2t6ejkOXGTsmCucUkf9r1twSWMuixoLSNjTIfAh7ywOQuvPlguNuklRUnD
         98GYy+FhBm4ngiJgk+JJzf1b5sA3LqP46aNx790mDAWcrmFxTB3dojNOrFobZ2/yxnS3
         JPnByztZ8Tmw/4OhD23O3cAClqFZaPbTnz3yTY0tMvlyX9x+8DrMb5zYOJvkkQGa4n2K
         1NXBcHgjO07jz7aQ0VPqe9m85XHu8E2ST5xoJbXxB+fcAEyaxLnHiig09Ayy+TzhgxrX
         lxcg==
X-Forwarded-Encrypted: i=1; AL+hErGftSz307sX0m3RfeBDsinlzsdPMk3eD+a8FXWoJq9mpZNmOOHDg2uGw31w+ZTv3Moljme6yQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+fFBGJGAayT4HE6HOzwC/8EcYeVsw90KBQzgC3XCrjochYhnkl
	jlW5kLW5fV4hGCcamg254NXJ6maActQTWBIy945rDcEfn7AdD6mwdquSOY6jrSpr3Wc=
X-Gm-Gg: AZFdTZdD9v/qJc8SKC7GApgvhc7Zxll+T3CDyPgRERq1xP9e7xLIYp5oBucjB/1bZ+W
	Thi3COkZg4j+KKLMXmw24GSDkFUrq3bLnGzY/wy7Xkz/RnOyF4+lXGQafuQnzUHob083weE08+e
	h/6u8Ucj7L6J9xzY64cMwbVcXCqFloATEoaJvIVa20cWFrd5VpTYkFFNjhF/RsIkrT+al14ZHiF
	83qNiWm/84v8usGqrafBmyldXggoM4nQT36XCok0fzyqYXV1My9A837udVz8s6bnfy7NT+ztV7a
	QqureIoirKlBgvyiyRX9+XqbK/MdvZ/igstWkiCKDcqXmkv9qQRvaR+OJTM0cAGreCpxrMAWlDR
	BafRqfvXAQX27lY7K5Ot7M+5sm7S5r6jVH7uAS3+44IUXbRqVbCkSfXkGfHG7OsVNIBTBVIuoPN
	GNOkRkb2gx51aP5FosE5ojrT22NYn+/HddkNvf97UapF43acsV0iCYPY+N5fzDiQ2GUMN8Vls0n
	KvQ106CNSWGf0oIcBHYaETRDKJdciUX5j3kpt8SP/usV3H1LmcsDFwaMph9yNwiQmBaQXlpcTIi
	aiX/n/hevt7bLURXwzAsXrxDSbAPRcwghNFJHAfk3lDLxwRkKEwkwNwoDRlLSyZYpe2/EtNqUwP
	RNVDP8X6X7c26nk2d4L5zUeje9VMPEf8OxpZOIumqdbBsTzt0l+43q0ozTIF8I08teKe5OmcDs4
	ZHCegLJ8X7wSdSe5Yxi9iSl6v+yRtyQcc5oTH+v46QIWiSq5YjscBB0Xp8/hTQTeMO
X-Received: by 2002:a05:693c:6383:10b0:380:d1bd:ed2c with SMTP id 5a478bee46e88-380d1bdeeadmr2109515eec.27.1794892061684;
        Mon, 16 Nov 2026 21:07:41 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380e031f3e5sm7128627eec.12.2026.11.16.21.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:07:40 -0800 (PST)
Date: Mon, 16 Nov 2026 21:07:37 -0800
From: Chris Down <chris@chrisdown.name>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, yosry@kernel.org,
	mkoutny@suse.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, ljs@kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 4/4] mm/damon/core: use node counters instead of
	flushing the root memcg
In-Reply-To: <20261114002822.1043378-5-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
	<20261114002822.1043378-5-joannelkoong@gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avvhGYhjBrOzAmT_@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Joanne,

I've tested that this works well.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris
