Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71202EC0A4
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366163; cv=none; b=bCpSgSan/+t4WU9x//TCI/0JoHJF6KmDiju/IgVQnHuxFxzHKsqc7Rys1kIy7neeOoPNPtac6Xe8weOEsh1ZV5xgmH7gHmjwxF1L7quxUY6CP5EdMK5PdefomhzaAZHtPDmzVIH20iAEenixD4n9n6FDE08j47Snh5pH1a8B51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366163; c=relaxed/simple;
	bh=8qjvbouH/m9hlChwftTDZTz31csl4K1sEbzUdM/+si0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFVbx+YjfznBEf6w8mE9GWLrFKfLIBmP/fq1aq4KVGu9hNwYDqF1yq9Ixt4ncDCIRiiQZ0Lw7AP+8/bJhi12Fp6sCEgDYgt17xcfYfMcx1TfE+zrJKZoUi4ElgWVEn53THvVxJocKDt6uy+h+g4yKmgGqcS5FCynxe5fTyvdmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyRr8has; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyRr8has"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4061F000E9;
	Thu, 25 Jun 2026 05:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782366162;
	bh=Ht1JrgXhlfGb6gxfBQKyYpxx22dMMuLhBngySeNNxDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyRr8haspscpmPGMiXZV71HMs6+3+7rncxNOfX3J0YEoPf3chGluTC477S4a5iPbK
	 x8vcsRmBF2u/F/SbwCMo5gt7XhXnsGOQDy8rV8RddIv4gm6hHeMoZlD8ga4tFlme3y
	 YWnbp+QA7u9/5uLV36rCfqtIZ3iRw8oPj898AK7JdN/4sXKL/10TlAiiEdDtihRd0d
	 E2oWTgGB2GhAsCtWQ6LBBAUyt2pqujBkMZYNnGCFi4Wmg/7sgYrkVtemTKIfFGTG0w
	 vGQH1+pP/FoDSLLpwIEhSZ81DPDp/hdxoJeSW5TzUl7Z0zPAS1si9+A+NVOqZQOFga
	 DoofCqaGwUSYA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 06/11] selftests/damon/sysfs.sh: test dests dir
Date: Wed, 24 Jun 2026 22:42:37 -0700
Message-ID: <20260625054237.99551-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625051449.E27CF1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jun 2026 05:14:49 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `test_dests()` function is never invoked, and its helper `test_dest()` omits a required argument, causing the test to be both unexercised and structurally broken.
> --
> 
> commit 53579293376a979c6b9c9914d1d77ffa57418d36
> Author: SeongJae Park <sj@kernel.org>
> 
> selftests/damon/sysfs.sh: test dests dir
> 
> DAMON selftest interface essential file operations test (sysfs.sh) is
> not testing DAMOS dests/ directory. This commit adds a test for the
> dests directory.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
> > index 07a33995be852..ffa8413b5ab3d 100755
> > --- a/tools/testing/selftests/damon/sysfs.sh
> > +++ b/tools/testing/selftests/damon/sysfs.sh
> > @@ -99,6 +99,29 @@ test_stats()
> >  	done
> >  }
> >  
> > +test_dest()
> > +{
> > +	dest_dir=$1
> > +	ensure_file "$dest_dir/id" "exist"
> > +	ensure_file "$dest_dir/weight" "exist"
> 
> [Severity: Medium]
> Does ensure_file() require a third argument for the expected permission?
> Without it, the underlying check might evaluate the file's permission against
> an empty string and unconditionally fail the test.
> 
> > +}
> > +
> > +test_dests()
> > +{
> 
> [Severity: Medium]
> Is test_dests() ever invoked? It looks like this function is defined here
> but remains unreferenced in the script. Should it be called from
> test_scheme() to verify the directory under each scheme?

Good findings!  I will fix those in the next revision.


Thanks,
SJ

[...]
