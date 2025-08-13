Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254115855E
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053159; cv=none; b=mey+Ztf74pgESSv2dPcOXe+Ho/ueRoVm299NgTL2gTIC8Q+pHy22Q3jjp1zbGbJ1XW2F+e1GX+k48x2Nn8j6+ive8BMJEJW+oJ399/VyXz3XuFykTfrKK8nLFJ9+xTvI2SebTYgo4Fq5E4sjRTFp1mAPz+25cIIpOTT3SCTKTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053159; c=relaxed/simple;
	bh=p6dvtiP+ZDxCLTpTe4srs33mURr8kn+OBoMUmqddGrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTOAnV4VhpyKx5k5x7J/YFgfkGlHyrWcmCrd1HTtShi8b6KxqaG8QJc/9bgRUpGyQbuenRROK2fljJM9KribabDhrW4N35vEaVTYDAwQRCMX1s7NWEhEqsPOfo6v2Pu/sCWbJWdC2nlB/CEHo4Ss6bv6WGnEnohUJ8fRj51keW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfXzH+Oj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfXzH+Oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12FCC4CEF0;
	Wed, 13 Aug 2025 02:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755053159;
	bh=p6dvtiP+ZDxCLTpTe4srs33mURr8kn+OBoMUmqddGrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfXzH+OjXKR2lFjnlWkQIBEwb3Kzig2Ax64rdsR7Cav5CppOwUSvmYHf3qs6OC4Dr
	 778Tn26yLQbgj/pPVCxJHpUCI6hxvIcXMiQ9YeWPzQeZUaW6lPe9DfqhN3P7HzDYko
	 L86i+ee5RrJzNWiA6dwgk2c5tR8SNxWILk9OjLT29H82JksxjP5unhDKywOIgFaTQT
	 wsAave6mckLLIuarTFXCNhxMx3Z2gW0ud0YbuIbZNcUY7N5k4gU/uKjBwPt8ff4Vx9
	 4g5+tfne+9OnEMbMbKyi585ZbSJhhzcV/1tIOBbUm259SBJm+YrS6Wph7djuXQ3R/q
	 ybSJNJQ+jla7g==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/damon: fix selftests by installing drgn related script
Date: Tue, 12 Aug 2025 19:45:56 -0700
Message-Id: <20250813024556.52376-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMF=-Fb56zSnGVvqXRrDXh-3vFzQmhuLNDYEzFv4z-bsuQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 11:24:27 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hi SeongJae
> 
> On Wed, Aug 13, 2025 at 2:59 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Tue, 12 Aug 2025 23:00:46 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
[...]
> > > While setup kselftest executable environment and test this patch [1],
> > > I found similiar issue. Honestly, I don't know exact solution for this
> > > situation. So I just make a new patch. Sorry if it is wrong direction,
> > > then please let me know how to do next.
> > >
> > > [1] https://lore.kernel.org/damon/20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com/
> >
> > For patches that you are not really confident about and hence not insisting to
> > merge as-is, but wanna ask other's opinions first, you can ask questions via
> > plain text mails, or post patches with RFC tag on the subject.
> 
> My meaning of "don't know exact solution" was about conflict patch
> (Now I read again, I think other people might be confused.

Thank you for clarifying!

> That's you,
> sob) I will use the method mentioned above from now on.

In the case, another (and probably more common) approach would be sharing your
finding of remaining bugs with the original patch author.  Probably sharing
that as a reply-to-all to the patch would be good.  Then, the original author
could revise and post the next version of the patch in a more complete form.

[...]
> Thank you for this comment too, and for your always kindness.

The pleasure is mine :)


Thanks,
SJ

[...]
