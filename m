Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9A2C0F8C
	for <damon@lists.linux.dev>; Thu, 16 Apr 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370994; cv=none; b=ouoRaorYfeU6i+cVDfPW5AqTW97fuVcuML/doqRKnZYvx5ctg298jegT+59RfUN9RhhqXiEvZErl6ZxWVqj6bbvMDA66Ao8Q448FU3Y6hoipihc8qvbp09GgUgAGZV4uRzRrJRkUXdvVIf98BV/1ZO7Cc7gYalAvdK/+JejfCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370994; c=relaxed/simple;
	bh=/jHN3AKrXKDhewo5A4ppG7b+41Xeu+rziVT/eh08bi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjaD02FS9tYvt4TnSgaAiO6TUl6Fna/Z9O43ewzPo8chGRbEUiEVa/++Azd8ng3p1CWbBDNL4wqu3cIP+WsZSaKaHKWByJbsIbE+mh+z3gm3GdJakukmUETUdCwnM55sqDBxRk5h8x56LnV5botp6kUHvlSBHzRZetnfWyzQlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oorkcNw6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oorkcNw6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50baafd6c4aso86641941cf.1
        for <damon@lists.linux.dev>; Thu, 16 Apr 2026 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776370992; x=1776975792; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQIC/zWz5OJ08TBOSJwx1m1q+xpY5Pl9ONSV8Ev4djw=;
        b=oorkcNw66M7NEkLZkSZIK21gmTOUfecbQOKsEQxd8sw+AVRw0l8qsfCx5FMFcfMXdp
         QvI+3vrqJ5eebf3bAoh+4Jj8X2REJ0I5vH816PF1pKBQID0X7w/9JSlE8f3blWWJulur
         nwNsD5u35GZIrp4/8cKu8NJk6JQoDClv+0GdGr3lwxKHiJ6BLUgIY3kWksIwrVvW/l9r
         cPXf5IQT+OjgQGgOfuyn9bmnKeXAtTk+tr/cDlKJCrCAhjciDmwMjij73wniF2/Blwky
         1yW25LnwJ1u5PVjl41zIlH+1lrigoMlVaudIPEjuanoXeJKV5I2K9MJ5NnjkZJ788K7T
         ciBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370992; x=1776975792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQIC/zWz5OJ08TBOSJwx1m1q+xpY5Pl9ONSV8Ev4djw=;
        b=IP8H6YIMZb5M9oc1N4GNXHDWtBAI1tDIzhahBFhQcvZmIMnkLV1DdYjseRoDJ07U9/
         pZSsgfYCmJgymah+9TSPElkNm08rgw2YMxQdjcpkgRpL6D9T8RMw3rjpMKxFUIUjosXe
         nybR9e2am+iSPhw5Uw5M9cq8sX1DBQI/li0wYk/tboDkaR8w6qXnAooqiKeYm/ZL8eca
         uXJJvvwAKhF9/Nj9SojEO5f45RkD6KYJKkw4R/c0UYqjfjPB1LGhk55nb4j6kGcMUntq
         RhfAVXbhNP6eTaXSCN2GJZsLSDeJY8AyE+aAMwcEsLqXKYpfJD3uUYr8JKqv2jvZmqVn
         fubw==
X-Forwarded-Encrypted: i=1; AFNElJ/SC1tix14GhmfdUTj5DIfeCkZi1KOM/rx8Rdp7t8Sibfo19Wj7K7+Pq+26R2/rc4hCYC9jUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxId3b0+ry0tNmwsyK2Ags+0bwJJafj/exUPMhlfqHtwcx1OUeY
	S/FXvSw7Uj4eSNInBWIw/gQQi9yLoC5glQ/yXvevKTYXevWwdqSKeg21BgTj50ZwT4c=
X-Gm-Gg: AeBDieusIMQMcqet0j25IXFbUhSlJbFhqKWJONqLUEsuYmpxzq9Do0E1QZGuXXlQYOo
	T3SpJXn8MxSmHJct3mH5gx8eXJ2mD0YwuCud9xtuEuCTJnwvobDrArngp5V9WjQKPT2aN03KrCX
	yiNES5U8xyp5YDQ2spbdsJ/HT9Aa2WWb227+XHAecJVvNhqbMjMP1b7EA7bPGUddbOQz0sjR//O
	XDPCXNwTDuJv6o4zxbgYcLO2DBwsfKV2D8WbDbMAzHxdhdPIG5MLZuBbfK4t4dKgDnokgGo6P98
	yoCRE90r0sBUJHxv63wCiERbooKNedmMf8iWBctm4yGDPBWAhevkdryfJbva197BTdk6P0LRhTw
	CYPv6U32snV5DLSj7kmzFC2febGiJKOOQm2Mhx2PkYSooKb3axDy+NrbZZVv8XEuolzOvJhn7Dw
	CViRugacWV7Bpe8IzhNKDoFqBJUSI5x5dIm/q4OU7I9FaWwYw5
X-Received: by 2002:a05:622a:7917:b0:50d:a7d9:d9af with SMTP id d75a77b69052e-50e34a76ca8mr7683091cf.53.1776370992242;
        Thu, 16 Apr 2026 13:23:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:ea1b:4643:9f36:3ffb:fc60:9518])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b0063easm49480691cf.29.2026.04.16.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:23:11 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:23:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Frank van der Linden <fvdl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aeFFKlSgOctW2W84@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>

On Wed, Apr 15, 2026 at 12:47:50PM -0700, Frank van der Linden wrote:
> >
> > > I also have some questions about longterm pinnings, but that's better
> > > discussed in person :)
> > >
> >
> > The longterm pin extention came from auditing existing zone_device
> > filters.
> >
> > tl;dr: informative mechanism - but it probably should be dropped,
> > it makes no sense (it's device memory, pinnings mean nothing?).
> >
> >
... snip ... stitching together some context here
> 
> So, looking at having some properties set at the node level makes
> sense to me even in the non-device case. But perhaps that is out of
> scope for the initial discussion.

I think there's an argument burried in this observation (useful for
non-device case) that suggests there could be a world where longterm
pinning on this memory makes sense.

But it doesn't need to be introduced from the start, and it's a 5-10
line change to add it in later, so I think it will get trimmed unless
there's a user out there actively experimenting with it.

~Gregory
