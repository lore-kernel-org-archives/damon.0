Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303E34846E;
	Sat,  4 Apr 2026 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336638; cv=none; b=OSzeFcM1OWNw5tMuDvde2x3klK2vnZ73wP0rY18A2pZkEg1zvWBW4r5FrXjZcxKU/RvVdTv4/o/BcwEvN9TX0bsZ8eS6j8nu6LhJTaKUkJYwV/07xnWT7iqfeE7Q4Y+EmGXAhGTyE0hg61twAvG/WPlkHah/93I1okRVCZwzuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336638; c=relaxed/simple;
	bh=iQs01XvDwKT3CkjOSudgaloppKITn+Eg0BEFKBlfobo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIh21uCttDxJsHXCwjs2M3iAKiXVrGNur0KJCGAx0QjV6sjJWwpv9Oa3UeyPHa/CicsDRJGEGA15tpcOVcQshaw3TJc2C8lX5sjjN5L7fFGSL7AYx/QsDSn7Cj0j1EzOwkoHCdQ/hHFIGYN9UBDkFnkc0whuFi94duVKJKxfg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7gwgdGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7gwgdGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FAEC19421;
	Sat,  4 Apr 2026 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775336638;
	bh=iQs01XvDwKT3CkjOSudgaloppKITn+Eg0BEFKBlfobo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7gwgdGmADNUUwD/aekEvGhbZcy9Gm3bBU9ogAusLr5f7uCqsg8fNcKswtJEYoulX
	 vPwa9EjkCwIDt/WkIPejq+XZ4w3o29502Ql3nDj52KZqzDenOlDcEtHRD/+No/SekF
	 rmVq++WQPi6tiwM1iOpqg/Q2pBJYqtNqyM29LZa/BM4ciEUo162sQ0CBEjSzr+FflG
	 P1zc8pUJpknk2dDuyRX+2XNpnkFToRrrfYCN66XtwsaTEkwCdXHpBslfZwt4iqXxRY
	 PdBlAvE+eAkRrMHfUMGJZY6XxgVMQVs4LGNT408+yakhfZvOgE4lGwep+FRj+tZ0jm
	 0GtVpvKNG1+dA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 6/9] mm/damon/tests/core-kunit: test fail_charge_{num,denom} committing
Date: Sat,  4 Apr 2026 14:03:50 -0700
Message-ID: <20260404210351.87638-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-7-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dropped individuals from Cc list to reduce the traffic.

TL; DR: sashiko made a good suggestion to improve this patch.  I will do so in
the next revision.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260404163943.89278-7-sj@kernel.org
> # start of sashiko.dev inline review
> commit 2c875b613d1b0d252222336af28714d95bf57930
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: test fail_charge_{num,denom} committing
> 
> This commit extends the damos_test_commit_quotas() kunit test to verify
> that damos_commit_quota() correctly copies the fail_charge_num and
> fail_charge_denom parameters.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 9e5904c2beeb2..1eb70f721d1e1 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> [ ... ]
> > @@ -717,6 +721,8 @@ static void damos_test_commit_quota(struct kunit *test)
> >  	KUNIT_EXPECT_EQ(test, dst.ms, src.ms);
> >  	KUNIT_EXPECT_EQ(test, dst.sz, src.sz);
> >  	KUNIT_EXPECT_EQ(test, dst.goal_tuner, src.goal_tuner);
> > +	KUNIT_EXPECT_EQ(test, dst.fail_charge_num, 1);
> > +	KUNIT_EXPECT_EQ(test, dst.fail_charge_denom, 1024);
> 
> This isn't a bug, but should these assertions use src.fail_charge_num and
> src.fail_charge_denom instead of the hardcoded 1 and 1024?
> 
> Using the src fields would keep this consistent with the surrounding
> assertions. It would also prevent the test from becoming brittle if the
> src structure's initialization values are changed in the future.

Makes sense, I will do so in the next revision.


Thanks,
SJ

> 
> >  	KUNIT_EXPECT_EQ(test, dst.weight_sz, src.weight_sz);
> >  	KUNIT_EXPECT_EQ(test, dst.weight_nr_accesses, src.weight_nr_accesses);
> >  	KUNIT_EXPECT_EQ(test, dst.weight_age, src.weight_age);
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260404163943.89278-7-sj@kernel.org

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260404163943.89278-7-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
