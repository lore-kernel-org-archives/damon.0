Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85B34D4D6;
	Tue, 30 Jun 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827668; cv=none; b=A8rv3T6/qWOKyvlDnMwvzxEi3rQydJsKcMTEsIxmswTDj6HfaL1lMyNRyBcxigRmQR4Q7FtklK7gHSw9AoTAZT6aoS+0rRagu9vI2Lguo0E5uoFK+0BkZfiaj2fyoW75iQ0Jusb21DgiXWZjmFpDOE+7jS7H2gfhzJySck3Zsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827668; c=relaxed/simple;
	bh=EjJ8n2p0YJreslKUMIr5BlljpHepIv6mzQg1Q9vEDmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ+YA10Yd6oUZU6fbv7YWUk0MOiqbf63Oih/RXueyUc3V1+UK48CO2PtfO+kCKpIgX7NjusvRAqDJlj9VlRQyUtTR5VMtsQgje5RBqJESCYOSCZGCua7RqcHEQMELw1F7T1MSV5isdPct8cH2tJ0fvSxm4lMwdv8hMyVixp3PEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSUAkoI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSUAkoI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681EA1F000E9;
	Tue, 30 Jun 2026 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827666;
	bh=CHy8fj2QP/6iAOuKSIp1H18G7/ohn39wma+CasIr1vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSUAkoI7ErGNLSg3Lck+NnYPYz/ij5rUVR+wPaG84BneHSVRRmG+V0uj7Lau2CQ5j
	 mVeGr+7iwgaof7Y+1JStM+9XcJFwrZHxUEyhLCLa9SueuZCDMk3ZIGifpvK7HTLadq
	 DauLNyIszUIu69RAQPnY+2d/VjPKeL1Vf22sf3YHrLdjxZzCqDZpu9/k5PhLsgvRzT
	 zcUXa0oNQrC3UcXvsdLmc7aLEoOrVziaS7Txxe2goq8MQRsS4bldA4l/OwDJUMaJS1
	 m/5V40IwWMHno/J35TxclI8W5j9gTdBG6EC59Z+Vi2HdwgMS08gewarYDC9trl4e/s
	 XdhW5z3nQx7JA==
From: SJ Park <sj@kernel.org>
To: Igor Putko <igorpetindev@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Date: Tue, 30 Jun 2026 06:54:15 -0700
Message-ID: <20260630135415.90926-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630130748.3908-1-igorpetindev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 16:07:43 +0300 Igor Putko <igorpetindev@gmail.com> wrote:

> Hi SJ,
> 
> On Mon, 29 Jun 2026, SJ Park wrote:
> > We prefer using a real name. I show you used 'Igor Putko' as your name before.
> > Any reason to change the name?
> 
> Apologies for the confusion. I recently reinstalled my OS and misconfigured
> my git setup. I will revert back to 'Igor Putko' for the v2 submission.

No worries!  I'm glad that I helped you finding a misconfiguration!

> 
> > As Sashiko also commented, this may cause lockdep warning. Actually this was
> > added to fix it. Refer to the previous discussions [1] for more details.
> > 
> > How about moving rcu_read_[un]lock() to the caller test code?
> 
> That makes total sense. I will move the rcu_read_lock() and rcu_read_unlock()
> calls directly into the KUnit test code in mm/damon/tests/vaddr-kunit.h to
> prevent the lockdep splat.
> 
> Regarding the pre-existing high-severity issue reported by Sashiko AI about
> missing check_stable_address_space(), I believe it is out of scope for this
> particular cleanup and should be addressed in a separate, dedicated patch.

I was thinking it is not a real issue.  Do you think it is a real?

> 
> I have just sent the v2 patch out.

From next time, please give enough time before sending a new revision (say, ~12
hours at least?), to ensure the discussion on the previous revision is
concluded.


Thanks,
SJ

[...]
