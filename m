Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FB3191B3
	for <damon@lists.linux.dev>; Mon, 15 Sep 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950109; cv=none; b=F2uVt2Lj7W/DUL9O4LzxPhGzSdt0ylA1LHGAAhQWicQGGaxEdS9EAn5JimKCwTEWd6MinOmZCyHZyEfFCSg5IY7ugfKRYQNGHwkB46iTar16/qMYGviD4cmChhh9FsGPafD9xXT/wgagXQJcS0VerMUDr0oXoDb2pipG7vgz0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950109; c=relaxed/simple;
	bh=CO5Kbl3OXWgTC8LZPs393tbcpXI0rUDxrixuD8t8JhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1lKminoilWCW9f54aomS3Gu04SzSQ0E8tMgFPyoIofTcDBnGiJjXuyjULjrSS5ER31shnV+MWRfJ6RA6ch4oRBgPv9PXd7vhdy2v9v6Et26iprnYm8rcfJfYw9KLwY8nksxFEYbh2UJURx83dz6hc/0FpyPsBOuj8pIMexFHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9wb5SDR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9wb5SDR"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea41621f73fso1011999276.3
        for <damon@lists.linux.dev>; Mon, 15 Sep 2025 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757950106; x=1758554906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiClITBt+CyIUIsQX+fBoErmvovdqrPoDXurgutbUMA=;
        b=O9wb5SDRVrBaOP+jbZ0AMjEbhtHi5RG1UrV9m+OkYE+dGVNLakbyIz4WmBDzA3yxGV
         TCOaOhVn939VJFFxve0E9FoeZjs3resxEFT/ZRPWrcpoYx6uH77yqMLOmc+WkQ9oChA/
         r6/gCw5p5P/50uSz7g0po74zPbdjEgSZd5TJCb6gbWA0ecbNwBtb1F4wS0T1PwyWImay
         aX3fzlyx89KSwtlyTh2JYQvSzCmnJhGGpeTJed7YwayPdKZr5O6zXPDl20NDMoa8n6pc
         aav4HbjJm+5F8/phabLdwxgVhhPfMtmviseKBIlnJGa8aXHQqfVSWa1x1B+hEE7w/PfO
         jXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950106; x=1758554906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiClITBt+CyIUIsQX+fBoErmvovdqrPoDXurgutbUMA=;
        b=B8LJp12DbZQJ2WExupPFsBzqK0lK1NrLwpe9WehtP5fIPf52x8469T7D0hdySwhIYr
         pIbXJ7xc3SGoBQnth+mYeBktWnUKIRufO6tYvzGNu7GkKnyz6UCY4rLRW3WkIS/Uc8rH
         HaNl9dBgHC0l1k+hHdxa+ZZgi8Oj56i0d/hxW1gCEInuA2BLmRIJHBZdidzf9GIlqjVp
         N670xfCDDFfdM/LxSH8mfhU2sckEB92xBu4d46X9RMXvg9rg0PbgR2S1pLc8GWj/AIQ9
         Yit/Z+Rntg+SkFjBtd+JtstiYbSUqucfkyWYwDgjqKGAtIsVDPpjWvFk/Q7piA8urbdY
         Ta/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3oqQhBaeQQAFyO12ySRg8U1DvsixyfxyIninLXTQCnZj/T2nyUhAp+8RKo4gX+D0BiDSY8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+i2nNgB8+Gk5eAoxhnyyXITLLBhcAYz0TEupM+0Olt7QSSNG+
	kWj3SelbvyQaecuLjSu/a1xy/ngad9bfjHfjc+YyxiLM8pt42W8cztCo
X-Gm-Gg: ASbGncuICjpZcABcFutXPdYNTNqIJ4Eny96G/OmO3EQCAKI45xJgJ3Zume0vV5qZUfB
	KxSWd+8nAKkoMBOFvUomBt/ehx731w4xZCaIcZai/rI1du583CVzNvegYVlIg2nNWZmEP4IpUBa
	UdlYFM8cDmd02WzGEAmXnXwouiZXk5Lcja6jaRwFDmtRbh0l5rdS0D/3zeIsjdNsMj2TyOmbGnU
	hA8/NqeA0HSnvSHU4X78AZ80F16MbBP0MJU8X92OgdlU5VKn4+87vUiYqqsOHggSzGQNfZd8NHl
	5L5LYpwDw2vLC4+VrAvXbO5cIoCAiRfmFRMjeW9IN5YYvDGHLa5aaljKixWWWRxGU99ngk74B1+
	aF8/I39Au9XSj8eSS94N/HXdrjnxonbouzFyd+tJoH0pVryng7AEjZw==
X-Google-Smtp-Source: AGHT+IHLKoGjQLIXfH7bFgayvLYdDgcTU1x7NMyUkMTH4LT0uz24DJ/2fWVkpnpcFtkckwGwJRVnpg==
X-Received: by 2002:a53:cb41:0:b0:612:891a:9ecc with SMTP id 956f58d0204a3-627202230a3mr8701789d50.9.1757950105297;
        Mon, 15 Sep 2025 08:28:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3edad05c0sm2586944276.10.2025.09.15.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:28:24 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/6] mm/damon: misc fixups and improvements for 6.18
Date: Mon, 15 Sep 2025 08:28:18 -0700
Message-ID: <20250915152823.1605591-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAJnrk1ZHdt-sj4n2VigW6u6bnd-gX47WpUfaHDxqN1BH4JGUXw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 08:25:40 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> On Mon, Sep 15, 2025 at 8:08 AM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > On Sun, 14 Sep 2025 18:58:01 -0700 SeongJae Park <sj@kernel.org> wrote:
> >
> > > Misc fixes and improvements for DAMON that are not critical and
> > > therefore aims to be merged into Linux 6.18-rc1.
> > >
> > > The first patch improves DAMON's age counting for nr_accesses zero
> > > to/from non-zero changes.
> > >
> > > The second patch fixes an initial DAMOS apply interval delay issue that
> > > is not realistic but still could happen on an odd setup.
> > >
> > > The third patch fixes wrongly written code that doesn't cause any real
> > > problem but could make code review confusing.
> > >
> > > The fourth and the fifth patches update DAMON community meetup
> > > description and DAMON user-space tool example command for DAMOS usage,
> > > respectively.
> > >
> > > Finally, the sixth patch updates MAINTAINERS section name for DAMON to
> > > just DAMON.
> >
> > Hi SJ,
> >
> > I was unable to find this sixth patch on the mailing list. Maybe it got dropped
> > somewhere? : -)
> 
> I'm seeing it show up for me, this is the link I'm looking at
> https://lore.kernel.org/all/20250915015807.101505-7-sj@kernel.org/

Hi Joanne,

Thanks, it seems like linux-mm wasn't CCed on the 6th patch. I should have
checked in /all! Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)
