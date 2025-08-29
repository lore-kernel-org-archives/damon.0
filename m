Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4531CA73;
	Fri, 29 Aug 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479896; cv=none; b=SlJsgkMtDNv6vHhfpkmEGmQiNpXjINLNnyIBz/Ciwyk4swta2kRslf6q3UVx7u0AeViEuCB6R7Lc3m75fOBDJu3egHO09OfCGx7+idchfzhBCi42XUWEWCQJiczRcX+oqk7nTVKKwIGoRdHSRprr4CeLATP4J89AWAXKZukMYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479896; c=relaxed/simple;
	bh=xtU8o3RRKlATt1ZkDZoqGZInz4LA3xlvTSiKt6WYT3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkmQVJ3RrQEdZRxVXRUdN6lotilgCDZqQZQHnJ6tdkH6Xtk+n0vFSbAnCGvDqOoc5XOYIXdpi+PlyTyE5l8NAYm33YAyTX4j4jAcylcLdtX+5lO+jQtv/4UtpEhfPtdSTl/qoWb61v2sYyg0yAgPvIalDHzzZUvz5EAtEY1d5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpR3njRx; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpR3njRx"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61da74ac09fso829519eaf.2;
        Fri, 29 Aug 2025 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756479894; x=1757084694; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtU8o3RRKlATt1ZkDZoqGZInz4LA3xlvTSiKt6WYT3E=;
        b=IpR3njRxk6/2nPvlgVUq8SsMhQUJnHTP4n1/5uR41y7ETisSgyHWIq0Pcvqfzr4C2K
         Qj3BNU/0PArk/LGUHolkUV0PTkwvl502qLQJ7gmlotK11+jxU3Xd1prlV2nwU27UYVnd
         z9orC0Tf0JylqktTXRzQiAwDwQqQQ1juN9Wms5vXqoVxbiZqz2tVtRoFaLZ+uUMWkpzT
         50yspFTPaTDWArS5AHTxH7T+8uEKurfEnWpNgdzDm9ENGeCD7rvp/HnXdvhZnZHJFy8Y
         xYayxD3UP8EDIPPjvB4rHJJIMjei+eW5xGdV7o4UOZC10xOZ3wkn86XppiDrHo2jYubM
         0sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756479894; x=1757084694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtU8o3RRKlATt1ZkDZoqGZInz4LA3xlvTSiKt6WYT3E=;
        b=KjOah1QjuUtaSCtKkTFw0vCBJEay7kgwjmElMRA/Vnoz4QuHByjOV1xDeTmOxTPVnl
         ETxF/wY+iHwAXeWsXIux6Sm6nRbUK/AgwPJ76BWwYrS9hpNzJqbdTWQ7UsqH21T6bRkl
         qzA7pinGwzmdCFJ2tMjKMpFTAceiB1sylAVzLvN6eu+u3Wn388/3NNnJgb3LMXlTFFo6
         ECaoroH69+yZpu9yBhFAB4EPEnLhvqozD4IT4RAByhZ8SPIqFx/VgAXssWm3Zbffx7rV
         cxivKVYlTg7NtGEHntvznM/9fmheO6C+lXpjtuCTBUChMQCit724EVMRYv6Un5b+rkS/
         hfWg==
X-Forwarded-Encrypted: i=1; AJvYcCWClGnUuC1tp+gXo940iaqvSnJcoD5upY9xKZHPlVXYQ7gmvXyu7s83J4RzTT6v8LCi4vSBbA==@lists.linux.dev, AJvYcCXv8fNKbschxfxpWIQ+8lqzrukbV7v5fYYBEYnWaHqPcT0lItB/pWzPKNvgVt5aMSIgW6SWgsAY/MU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzzjpCImnHO1P9Kd2ICLp/W532WaISl9Pr8RFUxUI6GL4VfWcn0
	/rwwunpanfBnP7Ta44V+sv36UFb+BaNEIxQWTuiLY+FaCNEeowJUAbTd
X-Gm-Gg: ASbGnct+2aFMPDY6sFNn1Xw0udoI4QUYz6VWCbBvfVDoSOYzgLFjeWtYt+GCnqoeH2A
	zQ973OmN67F7iFqbDdy6X5rFXV5nSyS1uzWTudQuYwglNq1io4JcyIkXmpyvxxZtyEIGPJ2QIho
	RQk8cFGK1KJVJP4A7L3r525hBIzSR2ZkOW8qRJmc7ACY3nubmLPxELesLtDxkmh2hWdiZ3tybuL
	h2Bpq0Lx4zCYVzsBBC4jOVP9n4XrhA+LVN31tdXTWOqS2iA0aZXg07f51KchfcxXXmC82KCZapt
	sZ2g0+CiArmMBVYiaQNx22c1h2U27KszuVuvyZpdT6rvVrZnd7xEHhcdTf+lfGqfwHYuzcXF7hT
	QDOUeEu+Mxejkyk6IYd03xt6lVQ==
X-Google-Smtp-Source: AGHT+IHoYRW1dTyT65+rU4V7sdHQy1ZAWCnUhYSUduVJT7h6pncITh0MMXOlALcxWQkuMLP36zurpg==
X-Received: by 2002:a05:6a21:339e:b0:243:9b4e:281b with SMTP id adf61e73a8af0-2439b4e296dmr15525181637.49.1756473541271;
        Fri, 29 Aug 2025 06:19:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bac60sm2408193b3a.63.2025.08.29.06.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 06:19:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 51DA0409D7C0; Fri, 29 Aug 2025 20:18:56 +0700 (WIB)
Date: Fri, 29 Aug 2025 20:18:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jani Nikula <jani.nikula@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DAMON <damon@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux KASAN <kasan-dev@googlegroups.com>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Linux fsverity <fsverity@lists.linux.dev>,
	Linux MTD <linux-mtd@lists.infradead.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Build System <linux-lbuild@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>, Andrew Lunn <andrew@lunn.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 00/14] Internalize www.kernel.org/doc cross-reference
Message-ID: <aLGovx7OpL_85YTf@archie.me>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
 <437912a24e94673c2355a2b7b50c3c4b6f68fcc6@intel.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v+QeNeXg1wIV/8Z8"
Content-Disposition: inline
In-Reply-To: <437912a24e94673c2355a2b7b50c3c4b6f68fcc6@intel.com>


--v+QeNeXg1wIV/8Z8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 03:18:20PM +0300, Jani Nikula wrote:
> FWIW, I'd much prefer using :ref: on rst anchors (that automatically
> pick the link text from the target heading) instead of manually adding
> link texts and file references.
>=20
> i.e.
>=20
> .. _some_target:
>=20
> Heading After Some Target
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> See :ref:`some_target`.
>=20
> Will generate "See Heading After Some Target".

I did that in patch [14/14], but I had to write out explicit anchor text
considering people reading rst source. When they encounter checkpatch warni=
ng
and they'd like to learn about solution by following See: links, they shoul=
d be
able to locate the actual docs and section mentioned without leaving the
terminal. Before this series, however, they need to click the https link
provided, which leads to relevant docs in docs.kernel.org that its source is
already in Documentation/.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--v+QeNeXg1wIV/8Z8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaLGougAKCRD2uYlJVVFO
oyLxAP95mJgSRTOQ+hTC3+7/hjakAGgQRjyWnfFgZF9dKlXeHgD/bJRCDtPLAnbQ
JLSf5TwAGdo1LgUd0wgEgetqhpMKwQI=
=82dj
-----END PGP SIGNATURE-----

--v+QeNeXg1wIV/8Z8--
