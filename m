Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505ED446857
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369066; cv=none; b=AecwqL+QtL8r6CX2e0fRO/J+3KTE+h0FGSi6hagmdrOwtYWy0TxsVb0l9ZhcKwpW41jjXyBafck/xE0IKTFWzByqBOoQqIopJ7+mwoO+W0gw2qNwVqy7fBfdTwV2BPiDM9LdBj5vZxjI7Tt5kGuM73o07JY2TWiLVUQW6Q/rm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369066; c=relaxed/simple;
	bh=Hp1AALNga/wt5gGc4JkUGXALvFY5gv8ltyhk/MAYvLQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R/mJyjwUV+o+fpiLwd9TZ0yt/Q1ZD3aHqjFzwgIv7xqO40zBUKV3z/nPaHhs8krqaA6wZyvsDRMGWYDtWadC8aw71Y68J0GQhLBjW2jJJJGmRKYcZgM+OmQxFDgmUT7PQiDcY5d9wjKpSO2kIwJNMQpXvKgXPsji3uZ0uLiGr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ecf2W1/p; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ecf2W1/p"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j08XY6fTxzMlLx;
	Wed, 07 Oct 2026 12:30:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791369037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Qacvnr9+rdohiy2Wh/N/8ObAl8Kh5+mo0TjMl6VdFo=;
	b=Ecf2W1/p6gXYnZ0aToASIXX/nhBCP9Ld2OBgnaX1tN4jhbl/WtGAEU5FMgTycWed4Q6eO6
	504I9Exym3TEjaUWXIMyReR9KXdpfuxYyX3uvq4Z9/kXnlQm4iNeOEBtIkxfyurnG8xM/s
	K14uYyTUIxO8ngD03YLYr9NPW6EEpGaAn7WxVEvkMzCk8Q3jo3qC6ver1eUsXYSpvHzucI
	hGj9wEaPopSHQtNzgLhr5k7XlW2Zu1yoAZsXMyQpuHCVK4GUllNJ6gdRZYmhOfcbL3ceb4
	4kQxVdNQahyfLoj9zoCOFYl8ABl+4r69+aGgiBDBJudzJnNyyXyHnwUjHGr+gQ==
Message-ID: <311d97da9ba4b870ef03aa412586b751bc7da3f5.camel@mailbox.org>
Subject: Re: [PATCH 1/3] Docs/admin-guide/mm/damon: Fix various typos
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>, SJ Park
 <sj@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	ahuang12@lenovo.com
Date: Wed, 07 Oct 2026 12:30:33 +0200
In-Reply-To: <20261006061549.627-2-adrianhuang0701@gmail.com>
References: <20261006061549.627-1-adrianhuang0701@gmail.com>
	 <20261006061549.627-2-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-ID: 0e0d33099551aaf3e49
X-MBO-RS-META: xas4d1k19jcabmc9ci34dwoejeb97b31

Hi Adrian,

I have read your patch and the affected files. I have found
a lot of issues, non in your patch.

This got kinda big, so if you don't want add it to your series
let me know, then I'll make a patch on top of yours.

Thanks
 Manuel=20

On Tue, 2026-10-06 at 14:15 +0800, Adrian Huang (Lenovo) wrote:
> Fix several spelling mistakes found while reading the DAMON
> documentation:
> =C2=A0 * trusworthy -> trustworthy
> =C2=A0 * DAMON_RCLAIM -> DAMON_RECLAIM

There's one more in in a comment in mm/damon/reclaim.c .

> =C2=A0 * charget -> charge
> =C2=A0 * hetmap -> heatmap
> =C2=A0 * colun -> column
> =C2=A0 * evelenth -> eleventh
> =C2=A0 * idlee -> idle
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> ---
> =C2=A0Documentation/admin-guide/mm/damon/lru_sort.rst | 2 +-

 DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel module t=
hat
-aimed to be used for proactive and lightweight data access pattern based
+aims to be ...

-situations including reclamation target pages selection under sudden memor=
y

+situations including reclamation of target pages selection under sudden me=
mory
 pressure.

-DAMON_LRU_SORT finds hot pages (pages of memory regions that showing acces=
s
+DAMON_LRU_SORT finds hot pages (pages of memory regions that show access
 rates that higher than a user-specified threshold) and cold pages (pages o=
f
 memory regions that showing no access for a time that longer than a

-You can enable DAMON_LRU_SORT by setting the value of this parameter as ``=
Y``.
-Setting it as ``N`` disables DAMON_LRU_SORT.  Note that DAMON_LRU_SORT cou=
ld do
+You can enable DAMON_LRU_SORT by setting the value of this parameter to ``=
Y``.
+Setting it to ``N`` disables DAMON_LRU_SORT.  Note that DAMON_LRU_SORT cou=
ld do

-condition.  Refer to below descriptions for the watermarks parameter for t=
his.
+condition.  Refer to below descriptions of the watermarks parameter for th=
is.

set as -> set to, a couple more times

there is '(de)prioritization', '[de]prioritizations' and '[in]active' -> un=
ify

-interval 5 milliseconds in minimum, and 10 seconds in maximum.
+interval to 5 milliseconds in minimum, and to 10 seconds in maximum.

-monitoring.  This can be used to set upper-bound of the monitoring overhea=
d.
+monitoring.  This can be used to set the upper-bound of the monitoring ove=
rhead.

nr_lru_sort_tried_hot_regions
-----------------------------

-Number of hot memory regions that tried to be LRU-sorted.
+Number of hot memory regions that try to be LRU-sorted.

bytes_lru_sort_tried_hot_regions
--------------------------------

-Total bytes of hot memory regions that tried to be LRU-sorted.
+Total bytes of hot memory regions that try to be LRU-sorted.

nr_lru_sorted_hot_regions
-------------------------

-Number of hot memory regions that successfully be LRU-sorted.
+Number of hot memory regions that are successfull LRU-sorted.

-Total bytes of hot memory regions that successfully be LRU-sorted.
+Total bytes of hot memory regions that are successfully LRU-sorted.


> =C2=A0Documentation/admin-guide/mm/damon/reclaim.rst=C2=A0 | 4 ++--

aimed -> aims x2

-DAMON_RECLAIM finds memory regions that didn=E2=80=99t accessed for specif=
ic
+DAMON_RECLAIM finds memory regions that weren't accessed for a specific

-out memory regions that didn't accessed longer time first.  System
+out memory regions that weren't accessed longer time first.  System

-automatically activated and deactivated with three memory pressure waterma=
rks.
+automatically be activated and deactivated with three memory pressure wate=
rmarks.


Thanks again
 Manuel=20

> =C2=A0Documentation/admin-guide/mm/damon/start.rst=C2=A0=C2=A0=C2=A0 | 6 =
+++---
> =C2=A0Documentation/admin-guide/mm/damon/stat.rst=C2=A0=C2=A0=C2=A0=C2=A0=
 | 2 +-
> =C2=A04 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentat=
ion/admin-guide/mm/damon/lru_sort.rst
> index b93ca9b0853d..c3b688385681 100644
> --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> @@ -7,7 +7,7 @@ DAMON-based LRU-lists Sorting
> =C2=A0DAMON-based LRU-lists Sorting (DAMON_LRU_SORT) is a static kernel m=
odule that
> =C2=A0aimed to be used for proactive and lightweight data access pattern =
based
> =C2=A0(de)prioritization of pages on their LRU-lists for making LRU-lists=
 a more
> -trusworthy data access pattern source.
> +trustworthy data access pattern source.
> =C2=A0
> =C2=A0Where Proactive LRU-lists Sorting is Required?
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentati=
on/admin-guide/mm/damon/reclaim.rst
> index ec7e3e32b4ac..e4e2ffa52e26 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -55,7 +55,7 @@ enabled
> =C2=A0
> =C2=A0Enable or disable DAMON_RECLAIM.
> =C2=A0
> -You can enable DAMON_RCLAIM by setting the value of this parameter as ``=
Y``.
> +You can enable DAMON_RECLAIM by setting the value of this parameter as `=
`Y``.
> =C2=A0Setting it as ``N`` disables DAMON_RECLAIM.=C2=A0 Note that DAMON_R=
ECLAIM could do
> =C2=A0no real monitoring and reclamation due to the watermarks-based acti=
vation
> =C2=A0condition.=C2=A0 Refer to below descriptions for the watermarks par=
ameter for this.
> @@ -125,7 +125,7 @@ quota_reset_interval_ms
> =C2=A0
> =C2=A0The time/size quota charge reset interval in milliseconds.
> =C2=A0
> -The charget reset interval for the quota of time (quota_ms) and size
> +The charge reset interval for the quota of time (quota_ms) and size
> =C2=A0(quota_sz).=C2=A0 That is, DAMON_RECLAIM does not try reclamation f=
or more than
> =C2=A0quota_ms milliseconds or quota_sz bytes within quota_reset_interval=
_ms
> =C2=A0milliseconds.
> diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation=
/admin-guide/mm/damon/start.rst
> index ec8c34b2d32f..d98b0eb8e771 100644
> --- a/Documentation/admin-guide/mm/damon/start.rst
> +++ b/Documentation/admin-guide/mm/damon/start.rst
> @@ -69,16 +69,16 @@ monitored access pattern of the process from DAMON an=
d shows the pattern in a
> =C2=A0human readable format.
> =C2=A0
> =C2=A0The first line of the output shows the relative access temperature =
(hotness) of
> -the regions in a single row hetmap format.=C2=A0 Each column on the heat=
map
> +the regions in a single row heatmap format.=C2=A0 Each column on the hea=
tmap
> =C2=A0represents regions of same size on the monitored virtual address sp=
ace.=C2=A0 The
> -position of the colun on the row and the number on the column represents=
 the
> +position of the column on the row and the number on the column represent=
s the
> =C2=A0relative location and access temperature of the region.=C2=A0 ``[..=
.]`` means
> =C2=A0unmapped huge regions on the virtual address spaces.=C2=A0 The seco=
nd line shows
> =C2=A0additional information for better understanding the heatmap.
> =C2=A0
> =C2=A0Each line of the output from the third line shows which virtual add=
ress range
> =C2=A0(``addr XX size XX``) of the process is how frequently (``access XX=
 %``)
> -accessed for how long time (``age XX``).=C2=A0 For example, the evelenth=
 region of
> +accessed for how long time (``age XX``).=C2=A0 For example, the eleventh=
 region of
> =C2=A0~9.5 MiB size is being most frequently accessed for last 3.7 second=
s.=C2=A0 Finally,
> =C2=A0the fourth command stops DAMON.
> =C2=A0
> diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/=
admin-guide/mm/damon/stat.rst
> index 46c5dd96aa2e..4a9db755a526 100644
> --- a/Documentation/admin-guide/mm/damon/stat.rst
> +++ b/Documentation/admin-guide/mm/damon/stat.rst
> @@ -81,7 +81,7 @@ Per-byte idle time (milliseconds) percentiles of the sy=
stem.
> =C2=A0DAMON_STAT calculates how long each byte of the memory was not acce=
ssed until
> =C2=A0now (idle time), based on the current DAMON results snapshot.=C2=A0=
 For regions
> =C2=A0having access frequency (nr_accesses) larger than zero, how long th=
e current
> -access frequency level was kept multiplied by ``-1`` becomes the idlee t=
ime of
> +access frequency level was kept multiplied by ``-1`` becomes the idle ti=
me of
> =C2=A0every byte of the region.=C2=A0 If a region has zero access frequen=
cy (nr_accesses),
> =C2=A0how long the region was keeping the zero access frequency (age) bec=
omes the
> =C2=A0idle time of every byte of the region.=C2=A0 Then, DAMON_STAT expos=
es the
