Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1744A6CC0;
	Wed,  2 Sep 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362404; cv=none; b=Nmfz4gtezG2YB+dNcuJVnvrty9ctRMMZH8PRMcf3YEBYv2C7Mt/5FACpoSa5IC9bkV3gzA+aShQ1HSjc+q+F5CgDUzApC74Efr56kti+nNcTZbfGs1cTPDhPlXbY6kqosDTo8PUedxH6bCklB+LXZPIZGiFMSuo8IAQSbTkXQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362404; c=relaxed/simple;
	bh=NFVBRBZp5DdpCmCsU1/ZmE187mRMxZ4l6mnWy8B/uLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dm3l9cCGLIyvEBB22mPupJ+ZtgOXZ+WJPFK9aCZ6RUZxMkxdFT39yiPthmQskHTU3C31vuwWHx1kV5zePHbRBxQ6krt1LCMgBoPIR9ts3yiI+sLWl/99B+1t7XuHTjjtalYOI9dSMxFTu5EaxVsOuyNGNo5S0AvTT0QMz/bgsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCjsPGcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCjsPGcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BA1F00A3A;
	Wed,  2 Sep 2026 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788362402;
	bh=EmdLDOUaG296P9CvbM12jSxYGxNeVIbHfGvENxwCkbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LCjsPGcIlubZv/I7kxnTj2vuAMW6xD6HCrWwLZXW54VpxsS9HmVQYzAWbRqwbRM7R
	 CrpUvX94Ul+n7/HGsKNLoQhlYASfOBEU2ugN6FckjCXhPzFEo1/5jW+cw901xqEDJS
	 VewGQoJQls9BbW7hfWc8pU/7YmP1txFV8PEhBuXiEgrghJI9s5V5j5LjaMQE4RMdPx
	 Fn1HdwMSsxyZ8fK7vCtiDCdXDtc5wt9GUHGfFs0FyOgsJYxP8ar1qJjIUh/n+hBmce
	 H2vMq1krBKRNqmKrybjJuHkCNZeajfyNjh24aBDEpCNJC+BD/MMyb5eYaO50iG5/5T
	 ZgWvEhZMnuaew==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 09/12] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Wed,  2 Sep 2026 08:19:54 -0700
Message-ID: <20260902151955.88892-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902150842.4033320-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 23:08:41 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> On Tue,  1 Sep 2026 22:47:42 -0700 SJ Park <sj@kernel.org> wrote:
[...]
> Both `sample_interval` and `aggr_interval` are zero here.  Since
> `sample_interval` is the denominator in `damon_nr_samples_per_aggr()`,
> would it be better to keep `aggr_interval` non-zero when testing the
> zero `sample_interval` case?
> 
> This would make the test explicitly cover the divide-by-zero protection.
> If the `aggr_interval == 0` behavior is also worth covering, perhaps it
> could be tested separately.

Thank you for your review and question, Kunwu!

Yes, that kind of additional test case would be nice.  Please feel free to post
a patch if you'd like to! :)  And no pressure, no rush.  I will also consider
doing it myself if it seems you are not interested.


Thanks,
SJ

[...]
