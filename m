Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF18362120;
	Tue,  1 Sep 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223357; cv=none; b=UtNpKJ0YK7DaoiUHyNf5DcLTNafrPQH+uoIR+u2AsCKux9qxiuw9ptCOCDdtPeIuAPZflO3jy38Qv9N9oKOyEycexn0lGmLoqCYT9vZD2SACCLIZ8o/oFLjT4d/66WAL8zXPez01t1emEIFmSXK++IM7Qaz5laFpJwVtIU60LbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223357; c=relaxed/simple;
	bh=dohq6U6ofDJB2hcH8LLGgh6LuwYpBMFe/DzadqSgnDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+ASxuP86gckyILCmA2QsS/RbgoFo2OpfFxu7xAMvaEDpKxdx80P5n2Y8SuQjEy69UlrE/DcU42FRtdhZpUv05YjL/ZzpYTvP6twG0E+rzm0YmpfqBpXvQJxHGwGOqfo0E0tKvYpf0U3BcPlpQTBXh8c8Hki3jaBDQMqjLjaVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbVgy6Pt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbVgy6Pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907151F000E9;
	Tue,  1 Sep 2026 00:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223354;
	bh=nfiaelhoKXS6U8IAM1Cx+D9jl8jdDr5cDRVvdKuWEJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nbVgy6PtpGfLQR8Pd/E0YXCDhX/7ZWVtMik/SHpvQnw247r6i0j7vL2Qj/8EBmp0d
	 iHVExvU4k+CcxAMzMQBbNjt4S+FQ50OP0pgfbocO6x6SpET7vrv6HtsJdI1R7haktx
	 HF+/LCRIGNQft7goMWMO2OkoI/5BbrBHb+2jw8mLimzWaBoN5+tiuwCMoAKmUtZB1r
	 3yMMYGWqL/+ThP7yHrXdVnJl4UUUH+hgjtNi4+kJUKBIjqTwTW+tLHbo3MapB/oz8N
	 uyn/nDPtafUbjmmh8/4MDJr/IOxWQ7P4zdH/WPKuqpcgHQN6jBVK5Ij3KubRbGx1Rv
	 NyN+UeBuD/BsQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Cheng-Han Wu <hank20010209@gmail.com>
Subject: Re: [PATCH v2 1/2] mm/damon/core: remove unused damon_targets_empty()
Date: Mon, 31 Aug 2026 17:42:27 -0700
Message-ID: <20260901004227.89243-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831161907.890b5e2d6c9a005205506674@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 16:19:07 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 31 Aug 2026 07:57:21 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > damon_targets_empty() has had no in-tree users since commit
> > 5ec4333b1967 ("mm/damon: remove DAMON debugfs interface") removed
> > its last caller.
> > 
> > Remove the unused declaration and definition.
> > 
> > Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
> 
> I assumed that a From:Cheng-Han was intended in this patch.

You're correct.  Seems I mistakenly dropped it while resolving a conflict.  I
will keep this in my mind to not make same mistake next time.  I found you
already fixed this when you applying this to mm-new.  Appreicate!

> 
> > Reviewed-by: SJ Park <sj@kernel.org>
> > Signed-off-by: SJ Park <sj@kernel.org>


Thanks,
SJ
