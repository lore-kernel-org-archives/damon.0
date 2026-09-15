Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B935280331
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438798; cv=pass; b=C34NC0yRZ4qh+NIeLWg3OywAzpChNSBDuiDnnq1cQ6NMaCxdqcNtHtQcp/e6BqFJFDiVsbD5c1NeK3NsElVQyczX9IVc0MTFu2Wkq3XBIDMeQHuVxkNaCotz9Db2qsYFKmtCSi3TBmuoG1up3tCG5QGpgs4vFi0gQz0gugjNJj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438798; c=relaxed/simple;
	bh=AMPDRjUt6HdBBpjJECQoFS9UOZEk/Aun9vZfZ71povQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUIat87Hyzm3j5ITe49S7zCMBJOVkvF39uyWe0QPttbjY2DafRvEm++vMkZtx3GCmSEnd5dAthkxq6X3XmRosLzOhtJXzaIz6DVL+Mr/jjag14IeF1IKuHxFC2uGa7q5hSn/nf5BbzRgd8z4FWFyyuybMqLyBCshevgrPszAY9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auHqqFJH; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auHqqFJH"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso845178f8f.0
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 19:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789438795; cv=none;
        d=google.com; s=arc-20260327;
        b=LHRi+SgiRgXbv4mDBHIw1MJExBlGD+6ijDP/VdWTYboY/kNe2DYK8ba1RWCm9Dngbs
         NpP10XKQPuTZJLvgqpKh9hyycuo4z0rvVxWLjr2dDcfPbIVBcekjgUTgQEn/LhnF62bs
         dMFEEk/Z4bkVfl+K6aaQDhUh7RDIDL7M0qoCWOEm6FRZ8/n9ylrWdRmRsghNRsnoimkt
         ceKHUuVtJ3Grbra4391hNk6qs2maJhEAUl4Y8XRGgmrDCKJ7WvznR0SSjI32gxxJoGWj
         CzjzCTrc2cEde2yJN0HXAuCqEV2vz7Bx0GfaY07HJnaXnvtXKJnxPF8hiyDzoDZinHGk
         mgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uz6pzhfSfo3jkEMjApuPj77vcnUzEs00MyRYle4FEto=;
        fh=wALUMXW8SdN908tJTQCfYDPz1yESqOV0INSoAbY/CRE=;
        b=OHRqlkY982vBreFIWJBbK7gNcx7QjOmtNLsZ0rfDLi41adP87AvvIhYSIkWAWRFK7J
         RkpdayAauZqLsC8LoTqYg5qGvLsSPgUNSzgVaK+l/U3r+JfPAn54QO8yCVwhHBkyF/HS
         WSXnoPMLsz1LaPAEcL6qZr7JLZv1+VSeM2O/VqM+4jAZQQ1dm1CfjSKDt0P22nq4hDgA
         /7KaDTw1CPmkw8Kl2rw+3X7DLQlyfbDmn7Z0/OR90KvRMU/8OfDBRUGXeRC9sQ7nbX8c
         U+5+u6F0ilGoK2KtHM4JDfbWbOiFbGxO5np+lYbSi6lMJ9RvCctT+RLKuSrD6BvY87KV
         uuyA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789438795; x=1790043595; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uz6pzhfSfo3jkEMjApuPj77vcnUzEs00MyRYle4FEto=;
        b=auHqqFJH58MEWluGRqci8pU5rHOyAeWzJ07TMZoWAthVDkGOqyYk0zy6fQ4RDOyAA8
         SH60cZcXs71MzAyDTHQP7HF18ik5S1q4CYek9EnP+GgPQYyovshZTtVqP9JQssYzp3gq
         99zuCMkUo0fE1lBUzdrvrkdWqwnwB2PVk1X3DwzcAW+mEtPUPrQYr9+jis6fbAWyXiWa
         fNQ2ddZ81u5c3JvkEOXvTiLL3JyRbSSqdDsqRXFHEJInAIVqpLL6atyQqaB9xW+HdfBt
         7ppa01apdOnmrSp7L5A00bMZsJXrj0QSGzzXz0kaoBdz0mJaxMXZzaz513gjAE2Cctxg
         tDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789438795; x=1790043595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uz6pzhfSfo3jkEMjApuPj77vcnUzEs00MyRYle4FEto=;
        b=CWLi3l9Bd25Z0RZ4NnOBvpN+iHcm0MmtwmMaHxCgV1q+WVuAkpvIWgWeF/GGWu0kep
         BVaX8Ho+k+/gCM0dOA128P6LYCaHxV9QlX6w4uYxFZArXdaRhspEhGqD2doF3rrLKXdC
         7CwvItR34DIefHy99R7lJu3UeobsuJyabozOR5ejstM4utTymVxtnuxFhxzTQiMsmt/+
         jHPgkrOa+g/yp/g8acuHJ21C50U4j6OC0HyIS6SMj1ogxAwKuW0AjtvqYZLIYr+OUECs
         7l358X+YkSqtfIZB8xzomSE8McJJPaZ311pJDk7hDgxnlJ2IYZ/U8Ixz+tUsfFy4M3jj
         FzqA==
X-Forwarded-Encrypted: i=1; AKwUvBwdrh/7GJsTvPxZMSLGmpMdZLMaa09CdjOf6Kmidp3jzEVeT7dAgRsLyUmXlBNw8D1sYGMe6g==@lists.linux.dev
X-Gm-Message-State: AFuF++lPoUZIqA/pgXmchXxQQt9Rrup5F8G8c1idI0dyHG6bB7Dwo60v
	n3+5TJ3D0AUl28+Jq+l3QJSIDgbb/nVna5b/T5+Dr1UKRUVYUQecGEQOqEDw6FRN78kjIfLnle8
	GaI6e4GVqwnb4rGvbdYFtBsn/haD37GA=
X-Gm-Gg: AYBFou1JAhWlx4WxjNmZTlaVyD/z7pT0b/Dki5LPZUmM13zylITzOqv96fddZnAGRcI
	ta5YmZ6jryGHL3jwnfZB6cyj4Wq0alg8/HLBY4rIWcWipvaLuXeCF4jMspmfkhOHiA2ZGpcEFv1
	cTlMRNytz325ZSei0NO8S5t55H4Nosexte+Wq0UKln3SMS8aNTUM4EXl5LK+tlUw9LiyiJF9v7D
	KBIjdnqg+90j5XznQjLz4snVAGdg+ET0wsojvWmNZaT7RaVPQlOpIyChfSjiDUYGWjvH8tvpURG
	mLga8MVorpLuJXO5d+wcPb/MsLkNS/hSCXsBkv9b6uronMnkY5x8x+szft94SbBL/KyC7P/AFIW
	ZS4DFZR/QnPsE
X-Received: by 2002:a05:600c:5307:b0:49d:1e79:35d6 with SMTP id
 5b1f17b1804b1-49e7d750cc2mr26446565e9.14.1789438794905; Mon, 14 Sep 2026
 19:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260914150150.1507525-1-kunwu.chan@gmail.com> <20260914151617.97903-1-sj@kernel.org>
In-Reply-To: <20260914151617.97903-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 15 Sep 2026 10:19:43 +0800
X-Gm-Features: AcwNN1W8hM-JtjZLNyC-iYEta08SQzUOjubSm-5TdDfo7dJjMBqxsOi_D3YW6Tc
Message-ID: <CAN_Opa8qSHcDNU8k=EWMywUADizJEhHPpuia3jMcZ13i5iYXgg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] mm/damon/core: use damos_quota_is_set() in damos_adjust_quota()
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:16=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
>
> On Mon, 14 Sep 2026 23:01:48 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrot=
e:
>
> > On Sat, 12 Sep 2026 13:08:05 -0700 SJ Park <sj@kernel.org> wrote:
> >
> > > damos_adjust_quota() is manually checking if the user set the DAMOS
> > > quota.  There is a dedicated helper, damos_quota_is_set(), for the
> > > purpose.  Use the helper.
> > >
> > > Signed-off-by: SJ Park <sj@kernel.org>
> > > ---
> > >  mm/damon/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index cf10f6d725c19..dd27068cb83e3 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -3344,7 +3344,7 @@ static void damos_adjust_quota(struct damon_ctx=
 *c, struct damos *s)
> > >     unsigned long cumulated_sz, cached_esz;
> > >     unsigned int score, max_score =3D 0;
> > >
> > > -   if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> > > +   if (!damos_quota_is_set(quota))
> >
> > Hi SJ,
> > This is more than a cleanup, because damos_quota_is_set() also checks
> > quota->esz, which the original condition did not.
> >
> > The path that makes this matter: damos_commit_quota() copies ms and sz
> > from sysfs but not esz.  So if a scheme runs with a non-zero ms, then
> > the user sets ms=3D0 and commits, the running scheme gets ms=3D0 while =
esz
> > keeps its old value.
> >
> > The old check would then return early, leaving esz stale.  That stale
> > esz is visible to damos_valid_target() and damos_quota_is_full(),
> > which also use damos_quota_is_set().
> >
> > With the helper, damos_adjust_quota() proceeds into
> > damos_set_effective_quota(), where the first branch resets esz from sz
> > when ms and goals are unset.
> >
> > The code change is correct, but worth noting the behavioral change in
> > the commit message.
>
> So, if user sets only time quota, and then commits the quota to zero whil=
e the
> esz is non-zero, esz is never reset to zero.  As a result, DAMOS keeps ap=
plying
> the action with the esz forever.  Correct?

Yes, the stale esz path is confirmed.

One clarification, though: it does not keep applying the action
forever. While charged_sz < stale_esz, damos_adjust_quota() still
returns early, but damos_apply_target() continues to apply the
scheme and damos_charge_quota() keeps increasing charged_sz.

Once charged_sz >=3D stale_esz, damos_quota_is_full() returns true,
so damon_do_apply_schemes() skips the scheme. Since the early return
also prevents the charge-window handling from running,
charged_sz is never reset, and the scheme remains permanently
inactive.

So clearing the quota can result in the scheme applying up to the
stale esz, and then stopping permanently.

>
> If so, this may deserve Cc-ing stable@.  Kunwu, what do you think?

I think this is a functional bug in the existing code, and Cc'ing
stable makes sense.

Thanks,
Kunwu

>
>
> Thanks,
> SJ
>
> [...]
