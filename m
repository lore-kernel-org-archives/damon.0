Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7228686
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807200; cv=none; b=LBqPEEIu/GxqvBIWIZ5YyiZSSuVUtEPqSRKIf6ilVdtgaQ6M1PWPuh+xjMaKrroeGPcff4CEQPGQZzALCE4lI5slL8OmOb5PYr4JRuEy6TlnIKoAJeB97EMQSZg7WcXHki2eUknh2L8ULg1vyox2Ir0UWHFXWlPHTzwAqt5YVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807200; c=relaxed/simple;
	bh=PIgiOc+fcfIWOPKrZUpr4lhgneZ87U2m7maJI7QdEeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MjbeqMuBx61DBiiKVO9uW0Mtq6X232qJuD4lCOJC+vbvPXZqB+2lJm1Xh0pimfD6CYE/eW5rkGXVIpbcQOcb/2PnlrNYF0U2p84qtTBe4ROloh9ch2q1PWF66M6vYeO5RiwCvVAIjHGs6WrCHefyya0ybftK+mD3mgS7v4ky3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8yahJMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8yahJMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126C6C2BCB3;
	Fri, 15 May 2026 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778807200;
	bh=PIgiOc+fcfIWOPKrZUpr4lhgneZ87U2m7maJI7QdEeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=h8yahJMqgqQy6CXv8jlUSf3c8bbs3RPIx0QuZnRKJZcM3oeZV1eIzSJ9Ihxnniu2H
	 6JpkyWewLPY8fXmQEn20j2l6B7fz6ajZKHw6kcXOWF0rSQLn8kKQAxo6b2ch0y0FhJ
	 ZkO31DAOYajwoq6/+ks9jzyd+Bh7HR8vHE5669FcuaMXV4huttLsdIlXE/ZJJGCI4K
	 tWoj43GSxG7/pgAUuFv9cYTKfvOFGuCmVJMFY3vOWfu7zK41cTPWWJnSqREMbL2/KB
	 Sl4O+UgkV3gwZFmuU54BUdBwYUSRn3A9Xy5nvOkQFUsI5+sXgOXySR8BTAZhWHbani
	 T+JewmMPw5Xkw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 21/28] Docs/admin-guide/mm/damon/usage:
 document data attributes monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-22-sj@kernel.org>
References: <20260515004433.128933-22-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:06:39 +0000
Message-Id: <20260515010640.126C6C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The documentation contains a contradiction regarding the sysfs layo=
ut for `tried_regions/<N>/`. The sysfs hierarchy tree diagram shows a new `=
probes` directory containing numbered subdirectories with `hits` files (e.g=
., `probes/0/hits`), but the text section incorrectly claims a single `prob=
e_hits` file is added directly in the region directory.
- [Low] There are several typographical, grammatical, and formatting errors=
 in the newly added documentation.
--

commit 1f54a921d1c61b444501227d66d664dd4513eef3
Author: SeongJae Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: document data attributes monitoring

Update DAMON usage document for the newly added data attributes
monitoring feature.

> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation=
/admin-guide/mm/damon/usage.rst
> index 534e1199cf091..44224da62533e 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -71,6 +71,11 @@ comma (",").
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 interval=
s/sample_us,aggr_us,update_us
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 nr_regio=
ns/min,max
> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 :ref:`pr=
obes <damon_usage_sysfs_probes>`/nr_probes
> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 0/filters/nr_filters
> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 =E2=94=82 0/type,matching,allow

This isn't a bug, but there's a formatting issue here. The indentation skips
from 7 vertical bars on the previous line to 9 vertical bars on this line.

> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 =E2=94=82 ...
> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 ...
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 :ref:`targets <sys=
fs_targets>`/nr_targets
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 :ref:`0 =
<sysfs_target>`/pid_target,obsolete_target
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 :ref:`regions <sysfs_regions>`/nr_regions

[ ... ]

> @@ -94,7 +99,10 @@ comma (",").
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 0/id,weight
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_appl=
ied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
> -    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 0/start,end,nr_accesses,age,sz_filter_passed
> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 0/start,end,nr_accesses,age,sz_filter_passed,

This isn't a bug, but there is an erroneous trailing comma left at the end =
of
this line.

> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 =E2=94=82 probes
> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 =E2=94=82 =E2=94=82 0/hits
> +    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 =E2=94=82 =E2=94=82 ...
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=
=82 =E2=94=82 ...
>      =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 ...

[ ... ]

> @@ -221,8 +229,8 @@ contexts/<N>/monitoring_attrs/
> =20
>  Files for specifying attributes of the monitoring including required qua=
lity
>  and efficiency of the monitoring are in ``monitoring_attrs`` directory.
> -Specifically, two directories, ``intervals`` and ``nr_regions`` exist in=
 this
> -directory.
> +Specifically, two directories, ``intervals``, ``nr_regions`` and ``probe=
s``
> +exist in this directory.

This isn't a bug, but the text now lists three directories ("intervals",
"nr_regions", and "probes") while still stating there are "two directories".

>  Under ``intervals`` directory, three files for DAMON's sampling interval
>  (``sample_us``), aggregation interval (``aggr_us``), and update interval

[ ... ]

> @@ -256,6 +264,27 @@ tuning-applied current values of the two intervals c=
an be read from the
>  ``sample_us`` and ``aggr_us`` files after writing ``update_tuned_interva=
ls`` to
>  the ``state`` file.
> =20
> +.. _damon_usage_sysfs_probes:
> +
> +contexts/<N>/monitoring_attrs/probes/
> +-------------------------------------
> +
> +A directory for registering :ref:`data attributes monitoring
> +<damon_design_data_attrs_monitoring>` probes.
> +
> +In the beginning, this directory has only one file, ``nr_probes``.  Writ=
ing a
> +number (``N``) to the file creates the number of child directories named=
 ``0``
> +to ``N-1``.  Each directory represents each monitoring probe.
> +
> +In each probe directory, one directory, ``filters`` exist.  The directory

This isn't a bug, but "exist" should probably be "exists" to agree with the
singular subject "one directory".

> +contains files for installingt filters for the probe, that is used to de=
termine

This isn't a bug, but "installingt" appears to be a typo.

> +the data attribute for the probe.
> +
> +In the beginning, ``filters`` directory has only one file, ``nr_filters`=
`.
> +Writing a number (``N``) to the file creates the number of child directo=
ries
> +named ``0`` to ``N-1``.  Each directory represents each filter and work =
in a

This isn't a bug, but "work" should probably be "works" to agree with "Each
directory".

> +way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
> +
>  .. _sysfs_targets:

[ ... ]

> @@ -600,10 +629,13 @@ set the ``access pattern`` as their interested patt=
ern that they want to query.
>  tried_regions/<N>/
>  ------------------
> =20
> -In each region directory, you will find five files (``start``, ``end``,
> -``nr_accesses``, ``age``, and ``sz_filter_passed``).  Reading the files =
will
> -show the properties of the region that corresponding DAMON-based operati=
on
> -scheme ``action`` has tried to be applied.
> +In each region directory, you will find six files (``start``, ``end``,
> +``nr_accesses``, ``age``, ``sz_filter_passed`` and ``probe_hits``).  Rea=
ding
> +the files will show the properties of the region that corresponding DAMO=
N-based
> +operation scheme ``action`` has tried to be applied.

Is there a contradiction regarding the sysfs layout for tried_regions/<N>/?

The sysfs hierarchy tree diagram updated earlier in this patch shows a new
"probes" directory containing numbered subdirectories with "hits" files:

    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =
=E2=94=82 0/start,end,nr_accesses,age,sz_filter_passed,
    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =
=E2=94=82 =E2=94=82 probes
    =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=82 =
=E2=94=82 =E2=94=82 =E2=94=82 0/hits

However, the text here incorrectly claims a single "probe_hits" file is add=
ed
directly in the region directory instead of the "probes" subdirectory tree.

> +
> +Reading ``probe_hists`` shows the number of data attributes monitoring
> +probe-hit positive samples of the region.

This isn't a bug, but "probe_hists" is a typo.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D21
