Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C726FDB2
	for <damon@lists.linux.dev>; Sat,  9 Aug 2025 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754760963; cv=none; b=KeKZ9QmqNtYobqEuzDxjW+T//uKyomGL6rLmnxP6Ux71ey8Tp/Ot3zk0JOXsSymjOJQoNtIoXyI2pKej9n4ssWJASt6go3r5GLVaIOEqSdnAtbr885XfRkAoNPLYQJs3PXCuM4v2a2tLIRNGA5Fe8TrRd/ecyDKuzA52SIvt9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754760963; c=relaxed/simple;
	bh=SWCxcOH9lwbVnD44cEsqOWOougLWaBTF3Y1gyrKV1qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IudxeLrbSMvpNTNEJZEuyIOb389YBSbQtJMebmnjWWZ6kESQMOftQ11BJl+d7eL1g6iKl3R+fQbjCvNpKLj3vfkn43InzYqLMIylcHGjfSpaSORJOp76Sad/kOzkXJ3kkpf4hMClUx4XzTPfUDLuEqv8XkbcMrW1s57Rj4FNmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coIi3MH/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coIi3MH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9E2C4CEE7;
	Sat,  9 Aug 2025 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754760962;
	bh=SWCxcOH9lwbVnD44cEsqOWOougLWaBTF3Y1gyrKV1qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coIi3MH/jyBZh+W4xMGEahH3bZIPlZMkcZEhJ7Xg16rrySXJeh7S/zLld66NReMJ2
	 Vzswt03DCOBaR4JYX83JeNWlsVV5eAZtgO0SFm/gIQ/DKEdayBl3qBEUob4YeJemZF
	 VraRlBTq/oCsanytyyik6EbncSwhhuQeWPQOiVCp/pdSD7dodhBKg++/t8No5L2L23
	 6ob2EJ7h418WTNGQVWjFw7NuOajbp1h3NCkbsPvUQjOLjGA6yHVZtJXass/N9K1gQR
	 vj6RV7+pYN6pCyfe+TEeu4KurNYrZoc4T2RZV4wM0Nvf36gXZzh5XqSWaknAK9sLBl
	 VWC7chIu87xIg==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] selftests/damon: test no-op commit broke DAMON status
Date: Sat,  9 Aug 2025 10:35:59 -0700
Message-Id: <20250809173559.71327-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMH0LDLLdJf-t2DEHCD40EJDfcq35cJM-HS5GkLX7KqsHA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 9 Aug 2025 15:39:41 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hi SeongJae
> 
> On Sat, Aug 9, 2025 at 7:05 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello Sang-Heon,
> >
> > On Sat,  9 Aug 2025 04:55:17 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > > Add test to verify that DAMON status is not changed after a no-op
> > > commit.
> >
> > Thank you for this patch!  I have some comments below, though.
> >
> > > Currently, it is failing. but after fix the bug it should be
> > > success.
> >
> > To keep bisecting goes smoothly, let's introduce failing tests _after_ their
> > fixes are landed.
> 
> I see. As mentioned in another comment, I'll merge this patch set into
> one patch. I think this comment will be resolved then.

That could make the patch be unnecessarily difficult to apply on older kernels
due to the test part.  Please keep those separated.

[...]
> > > +    if rc != 0:
> > > +        return None, f'drgn fail : return code({rc})'
> >
> > Let's not add a space before ':', for the consistency.
> 
> I see. I made so many mistakes like these; (I worked this very late
> night...) I will fix them all. Thank you for checking this moment.

I'm sorry to hear that you had to work on late night :'(  I hope you to have
sufficient rests.

[...]
> To be honest, I didn't use kselftest framework while making these
> patch set because I don't know how kernel developers use it.
> 
> If you are okay, could you share how you use it?

Sure.  I do below for running DAMON selftests.

    $ sudo make -C tools/testing/selftests/damon run_tsets

You could also run DAMON kunit tests like below.

    $ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/

I usually run all those together with additional tests, using DAMON tests
suite[2].

> I just build kernel
> with custom patch, and execute output images by vm, and setup env,
> then just execute tests(it's so raw.. i know)

It's ok.  No one fits all, so different tests are needed for different hacks.
Please keep using whatever works best for you :)

> 
> Maybe is there a kernel build option that automatically includes tests
> to output image? Or just a general or smarter way to execute the whole
> test?

To be honest I'm also not an expert of kselftest and kunit :)  You coule refer
to the kselftest documentation[1] for more details.

[...]
> Thanks for reviewing! Have a nice weekend. I'll do this job after my
> personal schedule finishes.

No worry, take your time and fun! :)

[...]

[1] https://docs.kernel.org/dev-tools/kselftest.html
[2] https://github.com/damonitor/damon-tests/blob/master/corr/run.sh


Thanks,
SJ
