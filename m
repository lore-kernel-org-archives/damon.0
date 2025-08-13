Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54414199223
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049783; cv=none; b=MW0UNQzYQ9riaY/GDg0Tn2h7HquOXh9bG/KNy45PzB0Jh0azIyucyUogGgB7EBieBy04yYRAExKPjLsc67llnqeXHyfuCe30BcMifi2Sibsz9V8/jgyMC3e09M9M5jBSJqCzVE1nWkQpLyLl7OyuSfMW3G2KCI9TPHnlNmwALgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049783; c=relaxed/simple;
	bh=dPOWDZ5li1du9dNQ6jbMsqrTaDrZLreTRbx8e97neT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvf8cG8COZ4Dge03+4eoVT+b2srIs8p+Dyu7Myxrjg0q/QN4g+rWOHlUv5zLyuNSWd4STV6WE/PXD6JOPLXM8OYtqAqsG2oEKJisWe2lMhZ/hoGFGhqwcDTkgX3Fyacg2/QHB56jEDwTwR21d2M7wSx2pH95mJu2SqyuBDjFDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX+hWeBr; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX+hWeBr"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61b51ad5809so2509905eaf.2
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755049781; x=1755654581; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aql2mwv9JTABH+xYsNRLchplJ9jbZwWvArEPle7Cru8=;
        b=bX+hWeBrGdwHrF+M0VKCdlJyDt1tfzFa/Q5LQq01EKQu7bZiSz01upTgvzllaSqMed
         /1+DV9KcCWxB0fNW1cn5+eyLn76tEyo4EeoTgpVcqYbhZFwN6IxIGyd535k7DEjQExu/
         k9B6sS0egiFFcN5MXoRCk1MEYHscxWP7SJexWoI09K9bRUSNgl+vGmUUvcPadxmXaQrT
         vVJstMZlnjs8PoKJwyteDT0sxn6gIoiwGYDN4Jy8gd94sMZiR9CktEKscnqJ76UmpOc8
         J8S62tgroEY3Kks9cI2cgjOxoRPNPgcoy1ERuH6cZkzHDVn8By65foUKi13g3PhR3Zju
         cIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755049781; x=1755654581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aql2mwv9JTABH+xYsNRLchplJ9jbZwWvArEPle7Cru8=;
        b=OatDQ0NTmAJXLjom5W8ZJE2qxCnOsAisFkmybw3mjbd+ocTSHERPIgWUbJbxLaEtng
         Vce9QXPFBhFn6lU7zMB1k62M6IPiBTYsnyHmGHE/N4M+DTphyxg9r8vBnuzGLOsMH1Cy
         9YBaFWaIZQMCd1SD5qYFKBjKmsBBeRSwXMlShjHNvnTdQVqxehDtUxcKexiD1RCRgrIh
         sojzcs9pg20+yNcPQTRgUgYa6epdXPIzaY4Vyb3JpqgHnSE03SXPuqqWZJ8TawfvOPnK
         eZAwxjiRgHNPUrFKVWYRCYWgJ6JvCKxJv3xx6PLnnZ9NOXt3+DqrfhqLeg/tM07Xv4S6
         PRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8NofNNEUs3KYVl+MMuDRYgsOmtrkptby8bBBYxpiW3r3akCKd8cmEvS0qR3aDlB7ZSJztRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxUHjO/tmL70GNN2s81Vvl/JciLD0YcA0ILwwJnvEeTUuLgfFT
	YFAm9p2WtNrZsphzc/yFW3v3mBfM3TxI3DxtQYUR8jP/sE7MHR2PMt5AcYi47Cv5pSrLn1OUBMl
	vm9e8OLnmzg2FAoSduEZwmxqww9N0GpI=
X-Gm-Gg: ASbGnctCwS9xxenZIlpctjDfNfkFqkZOEs1nKznZpaoJF3Ad0th8c3TD9o9FjWYykUu
	REgFvE2pbDliIX4rnmegSeTT4tZ6FQp3PEBVNSoIReBLqWTuNjXpyHg7X4yFw5bIfJwIu1suQ41
	Y0kyDzykmCSi0rAf3OyP3uF4eWkCg7mhjesKNFPuAl123KXGptEBKNuwl+aD0UN/YQdUOLxsxJb
	vwI
X-Google-Smtp-Source: AGHT+IE1J0i1gE3lpjE8L3r6M3x9LWFRM4yO8xP7DHLQDKGQcNPsPKYKJZsVHZVkCkUSbZlkd0WOpEdDB5+y8llfm/M=
X-Received: by 2002:a05:6870:80cf:b0:30b:6fa2:6974 with SMTP id
 586e51a60fabf-30cb59e360cmr834687fac.3.1755049781191; Tue, 12 Aug 2025
 18:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxMEQYx7fdx4T7meUb01FoqJaHcW_2RoYnBwJ8GzmJTexzQ@mail.gmail.com>
 <20250812172001.57104-1-sj@kernel.org>
In-Reply-To: <20250812172001.57104-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 13 Aug 2025 10:49:30 +0900
X-Gm-Features: Ac12FXx-U5LfozvxZM7PlT1XRtOr9ed905rkP1AtucJXvK8shutEgO6eRp4XuMg
Message-ID: <CABFDxMHjYDZDf6cObeKMSWmh2p-eYy_Nggzg9FK9HOXB-Pvpeg@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: fix damon selftests by installing _common.sh
To: SeongJae Park <sj@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Enze Li <lienze@kylinos.cn>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:20=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Tue, 12 Aug 2025 22:27:00 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Hello, Alexandre
> >
> > On Tue, Aug 12, 2025 at 9:32=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gma=
il.com> wrote:
> > >
> > > Hello, Alexandre
> > >
> > > On Tue, Aug 12, 2025 at 5:13=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> > > >
> > > > _common.sh was recently introduced but is not installed and then
> > > > triggers an error when trying to run the damon selftests:
> > > >
> > > > selftests: damon: sysfs.sh
> > > > ./sysfs.sh: line 4: _common.sh: No such file or directory
> > > >
> > > > Install this file to avoid this error.
> > >
> > > I tried to reproduce those error with my vm environment but I failed;
> > > with my workaround test method, it doesn't exist.
> > > If you're okay, could you please tell me line by line how you execute
> > > tests in what environment?
> > > I'm also struggling with the test environment, as well.
> >
> > I succeeded to reproduce and also check that this patch removes those e=
rrors.
> >
> > > > Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host=
 shared function")
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> >
> > Tested-by: Sang-Heon Jeon <ekffu200098@gmail.com>
>
> Thank you, Sang-Heon :)
>
> [...]
> > > > ---
> > > > base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d
> > >
> > > Does this commit exist in `mm-new` or `damon-next`?  I failed to setu=
p
> > > the same base-commit environment.
> >
> > However, I'm still not sure that this patch is in the correct
> > baseline. maybe it will not cause any problems with the merge
> > though... but I'm not sure. So I didn't add a reviewed-by tag.
>
> I think unclear baseline of a patch shouldn't be a blocker of Reviewed-by=
 tags.
> Since most DAMON patches are recommended to use mm-new[1], as long as the=
 patch
> can cleanly applied on latest mm-new and you don't see anything wrong, I =
think
> you can assume it is based on mm-new.
>
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile=
.html#scm-trees

Thanks for the notice! I'll keep that in mind. And also thank you for
always being kind.

>
> Thanks,
> SJ
>
> [...]

Best Regards.
Sang-Heon Jeon
