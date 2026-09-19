Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD01E7C18;
	Sat, 19 Sep 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789833311; cv=none; b=M1ahV5LPXTD5oNwV2HJm39wAJDNpYdUa2Tjwi/C9F4XbQxUfyi1ViYss/ViatQobZS+rkgf2WP85U2/6OBAvkFBciHWnoCIV9SIZJGqoM/HzTNUY8VZRqdxgkS6KLXgjOpH9YnoHsl0c77hCOMKbsQhItYPSiBrgTH9JV2ydocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789833311; c=relaxed/simple;
	bh=trMqCUestHIbZeJOOHN3QVUn8w7QUrEcBokjwjsfUFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLA7MRb3maTAm20FwVZ7B9dE2MG6axUr892dvxNdqjmnCP0g6Nketa0I+C2YfEgeTWkxGG2M00yJmoueKpyjyKoRh2KgloNWkDJoSjNwYKB+AuAq30wGVi6qYw2ReyTRz6F+2XLQLQ6jN6ailo6IrIAyM8BBy4bo23KxuP4OFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2ZdRdGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2ZdRdGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9137D1F000FF;
	Sat, 19 Sep 2026 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789833309;
	bh=B6BjE5sn0U6E/JVzt5jw8kZLRH2flS2xlqYcSGbx038=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2ZdRdGcRKiydZel/9OJ+ZO85Vlb9e/IhAgUzsFhvZCWzVleWaLCMfiSS6ow4HtKV
	 OXWBu38uvJ15HM84fyxkF8+VlnZeoyJZIT1qwHvSspUht3r3V7BEgLoBucl2M2h9Nm
	 4YSq469HAwpFX64g3ewxY+5yGwCQSME6T4pXSMvuABsRZLYbeY1/RErcTopIO/JImn
	 nBFs1v6QLUeTjheRZ1D7O+E+2nqcoHwx1MTYNgxNc8xf58zrwjgWEyGN8fWQA/wcAJ
	 Ur0VSPqGy3gvWK8L0JRoEOFKESzwBeoHKoWgd6NnmodJnXIShjD6Os4Vedojzt3h6b
	 HWoD0OO+5weUw==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test PSI goal rounds under the temporal tuner
Date: Sat, 19 Sep 2026 08:55:02 -0700
Message-ID: <20260919155503.85841-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aq4hU5DNjnGELpUT@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 07:47:11 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> On Tue, Sep 15, 2026 at 05:21:36PM +0100, SJ Park wrote:
> > So, this test depends on the memory pressure level of the testing system?  I
> > concern if that could make the test result not very reliable.  Maybe we could
> > split out the corner case handling logic to explicitly receive the current
> > memory PSI total time.  For example, like what I suggested in the reply to the
> > first patch of this series.  With it, we could build a kunit test for only the
> > target logic, without depending on the test system's status.
> > 
> 
> Yes, the second round reads the real PSI total. I used ULONG_MAX as
> the target to make it unreachable, but I agree that a test which
> does not read system state is better.
> 
> For v2 I can test only the helper from your reply to patch 1,
> with explicit PSI totals. It would cover both tuners, zero and
> non-zero esz for the temporal one, and the last_psi_total value after
> each call as Kunwu asked.

Sounds good, looking forward to your v2!


Thanks,
SJ

[...]
