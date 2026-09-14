Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16F2D73A0;
	Mon, 14 Sep 2026 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429772; cv=none; b=nxWBumC9Y6ia7bi+/yRLAKGyVyZBCYYX6ls+EHJz3G5fY4cPnP0kQxOUHUSEQQH5DQRzyS5AVV6/Yht7o7LRV8k2q3A+V34t+7EW3wL8JiSH8Hn5ZCVWT33stuWTnxQRm3lpLPwVHwjHYXXuWwQJ9fZatlyVArH0/0STiSri+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429772; c=relaxed/simple;
	bh=ZCT9nC32PC7LaY+hyGN3uSHNHOg82g2U4I9ApLLyFPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMl7fLJFGBi9ueTFZPUpj9GllbdY4nDT2h+K148suiTrfOdj/ac8g+WTNDbv1l/yd6XtXxlmSr3IHqmDKgoFktKgkPycn7p6eSKFWzAw1lfd/D1fefWwD5+Rss3XzAP9IPECZKkINzO2eySnXEVLblWCIjz+S9E/8eZQZqfN2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN2H49zm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN2H49zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE181F000FF;
	Mon, 14 Sep 2026 23:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429771;
	bh=qseDGL6DGTE6ag7V6hK0YAZQ8hJbvq3vxBHJNlYWSsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aN2H49zmND70doM4Uq/R1eHAz406bNkb1X77f9LZfStN6GJzJnawesoh6UpZxM6Am
	 NdsR3vpEyR4tHZ0QSsQloS1sX2Hlxi0rDv0mr2WZGWWZLAD2xzWoIoQCbuZBfO6RbT
	 +qrHjF3mCOh7qPYMXe2KXr87SQab3GHa36yhfAKSnkLKp+sss80SbMKDIF8L9AZjCs
	 71OMjj9EnxnT3eXQBN4ug2ztHxwqdXcD7gyUjop26I0HcRdxPTAbgPG/Xp5ElvQMHQ
	 gJfQnAL/5jRgLQSUB9hQ74/RU/iMHF+5PftAmwAEAKl5AxhcCzQQ3qH4VvWVlfoWf2
	 xlz+LASXH8DXg==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 8/8] mm/damon/core-kunit: test invalid damos filter commits
Date: Mon, 14 Sep 2026 16:49:23 -0700
Message-ID: <20260914234924.100335-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914155729.1518105-1-kunwu.chan@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kunwu,

On Mon, 14 Sep 2026 23:57:27 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> On Sat, 12 Sep 2026 12:18:06 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Add test cases for testing the validation of damos filter arguments in
> > commit time.
[...]
> Could we also test an invalid PROBE_HITS_WSUM range here?
> 
> Patch 4 adds the same max < min validation for
> DAMOS_FILTER_TYPE_PROBE_HITS_WSUM, but this test only covers
> ADDR and HUGEPAGE_SIZE.

I agree it is better to add a test.  But not necessarily together with this
series, in my humble opinion.  I am separately working on the test.


Thanks,
SJ

[...]
