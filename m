Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95089145A18
	for <damon@lists.linux.dev>; Fri, 31 Jan 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317932; cv=none; b=G5wTChb6xy58/Is+Fr0d96LP7/IKd0iFbJv0bT46HLdTZD/1EYLhV1RUGRQbmUgKQZDEU1TtprvR6Fq1KeA7AyO8KWrK4zQIln6rbxO+OEprlTzPD2HRXh9VFRhsRwFpCS/QKHEBJKaMPf7Yt8RqSC6pb88fTIm10Jq5vqJdOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317932; c=relaxed/simple;
	bh=HzSPRWM13nUBBCH7zosAUw0l082hAd2KNAk0Ze2VgyY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1cOkcNAoNhWcDezaoQ7GOAOjB/Wi9elCvYE+sX1Swg7GT8azcKpniwlThCOu7f4JATAlGu/QA1pq+9PQ5cQ7qhX/McX0MagcH+7Z6yuUFsdN0np4q3iABfQCXqVKkvNhI0+LwNTt7iZEP+UR3FADacFJ3VBbeBWHfA8ky9ybzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yks0B2bdRz6G8yq;
	Fri, 31 Jan 2025 18:03:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 17BDE140155;
	Fri, 31 Jan 2025 18:05:28 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 11:05:27 +0100
Date: Fri, 31 Jan 2025 10:05:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: SeongJae Park <sj@kernel.org>
CC: Yuanchu Xie <yuanchu@google.com>, Gregory Price <gourry@gourry.net>,
	<lsf-pc@lists.linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	Raghavendra K T <raghavendra.kt@amd.com>, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of
 Future
Message-ID: <20250131100525.00007d72@huawei.com>
In-Reply-To: <20250130034749.49417-1-sj@kernel.org>
References: <CAJj2-QF1y1XNRYy9sT5c5=pi20+67Duf9B2Amatnu01HLmw06Q@mail.gmail.com>
	<20250130034749.49417-1-sj@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 29 Jan 2025 19:47:49 -0800
SeongJae Park <sj@kernel.org> wrote:

> Hi Yuanchu,
>=20
> On Wed, 29 Jan 2025 18:15:08 -0800 Yuanchu Xie <yuanchu@google.com> wrote:
>=20
> > On Mon, Jan 13, 2025 at 7:06=E2=80=AFPM Gregory Price <gourry@gourry.ne=
t> wrote: =20
> > > 5) Scarce resources
> > >
> > >    We need to be careful not to consume excessive amounts of resources
> > >    in an attempt to track all these identifying mechanisms.  Even 1 b=
yte
> > >    per folio is 256MB on a 1TB machine.  This gets out of hand quick.
> > >
> > >    With task-work, I was able to add no additional resource consumpti=
on,
> > >    but deferring to a fully async scenario and needing to track things
> > >    like last-accessing CPU, timestamps, and etc.
> > >
> > >    We'll need to examine this closely if we decide to aggregate either
> > >    of these mechanisms. =20
> > My concern with physical address space monitoring is fragmentation. I
> > ran some numbers on a few prod machines. Grouping by regions with the
> > same memcg and ignoring any unmapped memory to be generous, machines
> > with higher utilization can have a region/total pages ratio of ~40%,
> > and even those with lower utilization (<50%) can also reach 20%.
> > Accurately tracking these regions would require quite the region
> > metadata, on the order of GBs. =20

I'd second this. Some cases are reasonably well behaved and
regions 'kind of work' for PA based tracking some very much not.
Add anything like overcommitted VMs on top and contiguity of 'hotness'
beyond very small regions goes out the window very quickly (unfortunately
I'm not able to share specific data).

So there are definitely cases where I'd expect something else to be needed.

There are a plenty of approximate tracking methods in the literature
that might be good enough with much lower overhead than precise tracking
(sketches etc) if we can feed them the right data.

Typically we don't need the answer on how hot all memory is, just some info
on 'this lot are particularly hot' and 'this lot are reasonably' cold.

Damon (as it currently stands) can sometimes give this info so to me
it's a possible producer of data for another layer that focuses on
abstracting the data to what we want only.  Hopefully we can make
that work for all the forms of tracking temperature that people are
looking at. I'm biased in favor of hardware units but no everyone will
have those toys available for a while yet :)

>=20
> You're right, if we need page level accuracy access monitoring and want t=
o use
> DAMON with its regions based mechanism for that, the memory overhead of
> damon_region could be high.  That's mainly because DAMON's regions-based
> mechanism has not designed for such usage.  It is more for a best-effort
> tradeoff between the overhead and the accuracy.
>=20
> Regions-based mechanism is not necessarily the only mechanism of future D=
AMON,
> though.  If there are use cases that regions-based best-effort accuracy c=
annot
> be used while exactly the page level accuracy is really required, we can =
think
> about optimizing regions based mechanism or developing new one.
>=20
> But, IMHO, the page level accurate access pattern is not always essential=
.  In
> many cases, being able to distinguish some amount of regions agains others
> based on access pattern is practical enough.  Indeed, DAMON has been used=
 on
> real-world products with physical address based moitoring mode for years =
with
> no significant problem.  Also I think physical address space based monito=
ring
> results[1] on a real server workload that I shared recently seems not ver=
y bad.
>=20
> Of course your use case could be different from what I have experienced s=
o far.
> I'm curious if and why you really need page level accuracy.
>=20
> [1] https://lore.kernel.org/20250110185232.54907-3-sj@kernel.org
>=20
>=20
> Thanks,
> SJ

