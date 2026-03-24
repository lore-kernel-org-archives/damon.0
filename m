Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174A381B12;
	Tue, 24 Mar 2026 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325333; cv=none; b=k9lziJkFZdjwOHQNqqjysNkhtzLq5qnKCpfVWO68CsolQwH36wQhjC+AoVUczeOkrm/vYp1Kx5q16ewIKYuZDUuA8ZCOtb3Um9+RhwvyL67SiJvzTi2csk2f1749Y9vRssgsx+Dv0J+2FArLLtjSmloAGCVqZkaR9nFeeIZoy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325333; c=relaxed/simple;
	bh=79XuQrnsihtiEE5YsTLFUzqNzacWkJMn2AsEJnnaw2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJL2W8SLBT4hRWD6MPDXbQ9ffh1lUGUIIEW6k3QN0zjHGQpzAZWkm1AsDp2wHDDASZ6mSAR0QIE5FU70mREglJjv9jOEZpp10yhDS21xWzrg8muXXvb2dCcNGZi7zWoINgDpfXZyov3jkLq6iQDSnYYM8dxiafBEP4B4Ni3wEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swMnSffl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swMnSffl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84331C19424;
	Tue, 24 Mar 2026 04:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774325332;
	bh=79XuQrnsihtiEE5YsTLFUzqNzacWkJMn2AsEJnnaw2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swMnSffllabeTV0erKbu1hhgJnFGHRfKchRAuKRvXLKdhmk8mN19fbj28cniILeVx
	 I+kmKmAb7NEeLYJRkW0LN6hjIhptKz73DbZHYj85ENNKxg6PfNkBOcaTek5oJVl0Mv
	 lBfxfOteItCXB+GA4rM8Iotpa9HeBk2sQeHeq3tikwL6qNEfAMrxbpYg7VIpckHsh7
	 qR3wGfE9+9DQYKltNXogOuD4Q2sj41K2WJFOjXrm1zV9dfmAa2Q9glq3qS8r11mPg+
	 uTlRoAMbVyqNcYSF/g9XDhXJtlFVoxYgdy2m/oaXya6bBFWPTgTnuJu+mU/bhmol1g
	 m3HIxBMR0djOg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Mon, 23 Mar 2026 21:08:41 -0700
Message-ID: <20260324040842.58055-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324012825.46899-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 18:28:24 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260323231538.84452-8-sj@kernel.org
> # start of sashiko.dev inline review
> commit d9ca6c4a33fc4d613982730edda6f4b67ae30a67
> Author: SeongJae Park <sj@kernel.org>
> selftests/damon/_damon_sysfs: support pause file staging
> 
> This commit adds support for the newly added pause file to the DAMON
> test-purpose sysfs interface control Python module.
> 
> > diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
> > --- a/tools/testing/selftests/damon/_damon_sysfs.py
> > +++ b/tools/testing/selftests/damon/_damon_sysfs.py
> [ ... ]
> >  class DamonCtx:
> >      targets = None
> >      schemes = None
> >      kdamond = None
> > +    pause = None
> >      idx = None
> >  
> >      def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
> > -            schemes=[]):
> > +            schemes=[], pause=False):
> 
> This isn't a bug introduced by this patch, but since the function signature
> is being modified here, is it a good time to address the mutable default
> arguments?
> 
> In Python, default arguments are evaluated exactly once at function
> definition time. This means any instances of DamonCtx created without
> explicitly providing targets, schemes, or monitoring_attrs will share
> the same list structures and DamonAttrs instance in memory.
> 
> For example, self.monitoring_attrs.context = self overwrites the context
> attribute of the shared DamonAttrs object for all default contexts.
> 
> Would it be better to change these defaults to None and instantiate them
> within the method body to avoid unexpected state sharing across instances?

I agree changing the defaults to None is a good idea.  But that would better to
be another patch, not this one.


Thanks,
SJ

[...]
