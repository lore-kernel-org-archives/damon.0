Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705384;
	b=yus7OLMrnRcCKj60s83P5yyr4Q2/XUl5ZjQ8ArckteIDSfnNxHSo39k2B75yNqZKbjtA
	 yD2QdfXhNMN1PAiUggDwPFQLfNYLvlr8LuAWnCqQ4x66HUBdGZ+ekkaWl9B1sHOu8Owbg
	 /H+9eWHBdtYJYpgHGFYQn5WEstoslOUZM4T2Xwpgy5jBOVcCt1DNNHi0qbdUXxcQPrQPm
	 Pesu7wHbOIXkyLA4wibFufHMHwqjmpZdHgeLet68bXgCKTHVjzAaTlIrod+8saJcyUz/c
	 2uPbVVqg5mMC084RQLTjnK7DCGTCRVDu9MXXboMY7ixF4gozVw2mZPUdK0FikPWnPGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pLKPltpOKrJeivfZ4qfED8CPkzZvz3KzKJEccxtQyxE=;
	b=RgBdLYMebJiCdsXFef+ZVHnOl+qPvXyCwP2j2zjP4RtzJ+hOl7NgsaSuoFLPt7ly2jkO
	 FGWO0uNZfNts15wnouMCrLjC9nrrCpXdyuKP4ejFYI5fkUUsf3hYJAJYJ4JPS4lNurxKb
	 IXF9+CGU6cKTCwAo1ySx0T4KALmfBnNMIf331BfwJc5iiB40GMVk0Pfraad9h4VG+yjMA
	 4ASaIFSE6OBM5Xbb4JZeXlI9p5AOQflAJg0dKnwdzzb7gSy4N2/4RY92FTgxkJDUJrGLn
	 e830gdR+n6kYq6+fVwuP5MVcWraiPrq7CK0CZXbH/bEoATUuHcP7I4pLRtYqqI14VQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eM3VbPfa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B451606C541
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eM3VbPfa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5504E1F00A02;
	Tue,  3 Nov 2026 11:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705384;
	bh=pLKPltpOKrJeivfZ4qfED8CPkzZvz3KzKJEccxtQyxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eM3VbPfa7wawjF5nU6A0ctvbSq1HaIv3xtC3m8UTaP+3sc7J4X6m+MLj/JKQGSQu0
	 OiesQyiWwiKBh7oCBbcaH6/AgHm++Si8ln0YhocGDY/M6zemUy1kIEwDqbpKmRNs6m
	 2fftZ2T7Z3A9xzMcS6AXJ23fPzULtvF8MJBBj1NOGrEJmKikk4WIVp4eBr7KyVcY5b
	 Rc3t9oLEtEOewXvnPCM0uO6hSb18zNgjDPPWT0ZWnrkyG9Ik/0Rhhgive9Gm6m+SB1
	 FlG+EKGkaHO7VcVPez/Ee8kweyKH/fquCZB4Eg8uumIscXyljJ1H4hBGuM6mUeI5Kc
	 ZMkLVIMh6TlJw==
Message-ID: <sashiko-outbox-195152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: reject empty access pattern intervals on
 scheme commit
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WGlhb2xlaSBXYW5nIChLYWlob25nKQ==?= <xiaoleiwangxiaolei@gmail.com>, sj@kernel.org, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, error27@gmail.com
Cc: damon@lists.linux.dev, linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, "Michal
 Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Vlastimil Babka" <vbabka@kernel.org>
In-Reply-To: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
References: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:29:42 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon: damos_validate_scheme() breaks DAMON sysfs.py selftest
--

commit f1effb4d8401c0508f7cb04b14b9b55d0d6abd17
Author: Xiaolei Wang (Kaihong) <xiaoleiwangxiaolei@gmail.com>

mm/damon/core: reject empty access pattern intervals on scheme commit

This commit introduces damos_validate_scheme() and calls it at the start of
damos_commit() to reject DAMOS schemes with reversed access pattern bounds
(min > max) or non-monotonic watermark thresholds with -EINVAL.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d36823f4d0928..9b2b2a63a2576 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1561,10 +1561,29 @@ static struct damos *damon_nth_scheme(int n, stru=
ct damon_ctx *ctx)
>  	return NULL;
>  }
> =20
> +static int damos_validate_scheme(struct damos *s)
> +{
> +	struct damos_access_pattern *p =3D &s->pattern;
> +	struct damos_watermarks *wmarks =3D &s->wmarks;
> +
> +	if (p->min_sz_region > p->max_sz_region ||
> +	    p->min_nr_accesses > p->max_nr_accesses ||
> +	    p->min_age_region > p->max_age_region)
> +		return -EINVAL;

[Severity: Medium]
Does this validation break the existing DAMON sysfs kselftest in
tools/testing/selftests/damon/sysfs.py?

In tools/testing/selftests/damon/sysfs.py, main() constructs a non-default
scheme for testing online parameter commitment with min_sz_region =3D 4096 =
and
max_sz_region =3D 1024:

tools/testing/selftests/damon/sysfs.py:main()
            schemes=3D[_damon_sysfs.Damos(
                action=3D'pageout',
                access_pattern=3D_damon_sysfs.DamosAccessPattern(
                    size=3D[4096, 2**10],
                    nr_accesses=3D[3, 317],
                    age=3D[5,71]),

When main() subsequently calls kdamonds.kdamonds[0].commit() and
assert_ctxs_committed(kdamonds), writing commit to the kdamond state sysfs
file invokes:

state_store()
  -> damon_sysfs_handle_cmd()
    -> damon_sysfs_commit_input()
      -> damon_commit_ctx()
        -> __damon_commit_ctx()
          -> damon_commit_schemes()
            -> damos_commit()
              -> damos_validate_scheme()

Because p->min_sz_region (4096) > p->max_sz_region (1024),
damos_validate_scheme() returns -EINVAL, causing kd.commit() in
assert_ctxs_committed() to fail and exit with status 1:

tools/testing/selftests/damon/sysfs.py:assert_ctxs_committed()
        if kd in kdamonds_paused_for_dump:
            err =3D kd.commit()
            if err is not None:
                print('pause fail (%s)' % err)
                kdamonds.stop()
                exit(1)

Should tools/testing/selftests/damon/sysfs.py also be updated to use a
non-empty size range (for example, size=3D[4096, 2**20]) so the selftest
continues to pass?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103105418.3624=
59-1-xiaoleiwangxiaolei@gmail.com?part=3D1
