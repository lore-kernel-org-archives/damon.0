Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F4274B53
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699515; cv=none; b=rWWQBRR0Sn4v5Uz+W2UnyMhSEwlFWtcnFZ7T/uWWc3BojLeAzsaqTCRH1N1VgqRWAn0ER8dg8hiZxe3M65BgkRCmlWGnrtvhvTD7wnraPvv0UUn9kyDa9f5fUgS+6sEpqNYVmfrAM9Gc0sFUHKMDylQWhKAtcGGlASNNaSJ/c+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699515; c=relaxed/simple;
	bh=GeDNviqQSoLOJWu2U0uEky1r++R+rN93+PAIz17N/Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neuEpB4eG9W3KA3afT1K67hHrnocHjO8odal1I7fO5JU0NwKoeTg/vmhb8E9ZMEjpg1/v5zohK4AuUy74ftPIKD1zUM6B5L9m61uk/QETh4Al6srcwREXF29sW84Wz1o0W3dPZkqC1znuFYh6IVTMvu3umr/U94QkYRg9J1mayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtO4oQkX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtO4oQkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955701F000FF;
	Fri, 18 Sep 2026 02:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789699507;
	bh=R14pZAPKTWtI40ZADQt5vUsL+yTt0PnIysZP3xDrxNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OtO4oQkXL394zylW82oIJ6NtcnuMCH0GboyXLkcRE82GQ1VqTcxYV0CF+943S/Mdt
	 eM8i0IXyTk/PpqoSKLqaAMirncYISOzlieMlKabxQO6kSXkZ0fixNLYCpra6PK6k2F
	 nLHcn8qwYISLNITyqWoIjKieG6F0PwiixB07KRyeV7oCxI5nu9iX1TOuBwDAGfIZbQ
	 a1TtRotorlZd6hMU0Cdxrn/7JtfdA2m0C480ksgtghAT7oHfVf1mgMD9ShbLrwnDAM
	 0Per22B5/ozytgIPdFZJjUqlaZ49mSwZYbV5RstHHMkopT/uuu8A2gP8FWwHOriT5v
	 ic6D8ajN5ZMJQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Implementation for paused kdamond
Date: Thu, 17 Sep 2026 19:45:06 -0700
Message-ID: <20260918024506.13715-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917153238.76020-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 23:31:53 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Mon, 14 Sep 2026 17:28:35 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Mon, 14 Sep 2026 23:35:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > Hi SJ,
> > > 
> > > I noticed that the current implementation for paused kdamond is
> > > periodically applies online parameter updates by kdamond_usleep().
> > > 
> > > I'd like to know if we should change it to waitqueue to achieve a lower
> > > power consumption?
> > 
> > I'd like to make a data driven decision :)
> > 
> > > 
> > > Previous Discussion
> > > ===================
> > > 
> > > I noticed that when you introduced ctx->pause [1], Sashiko asked the
> > > same question, and your response at the time was:
> > > 
> > >     "sample internval is 5ms by default and recommended auto-tuning
> > >     setup makes it hundreds of milliseconds.  So I don't think such
> > >     change is required."
> > > 
> > > I'm curious that, did you think it wasn't neccessary to change it to
> > > waitqueue when it was introduced, or it wasn't neccessary to do so even
> > > after it had been introduced?
> > 
> > I guess I thought so when the quiestion is raised.
> > 
> > > 
> > > Asussmption
> > > ===========
> > > 
> > > This is just my assumption, not a real use case I knew:  When 'pause' is
> > > set on an Android device, user might want DAMON to stop running
> > > completely when the screen is off, thereby reducing the load on the CPU
> > > without losing important information such as regions and age.
> > > 
> > > The current polling may make it harder for the phone to enter idle mode,
> > > resulting in some unnecessary power consumption.
> > > 
> > > However, pause feature is only present in the stable version v7.2 or
> > > higher, and since the latest Android kernel is 6.18, this highly
> > > unlikely will affect any Android users.
> > 
> > If whoever comes with a data that require changes, we can discuss.
> 
> Thank you for your clarify.
> 
> I recently backported the pause feature to my phone.  However, due to
> Android's screen-off mechanisms, I wasn't able to obtain any valid data
> during testing.
> 
> Since we haven't identified any practical issues with the existing pause
> feature, switching to waitqueue isn't neccessary at this time.

Thank you for checking this.  I agree.

> 
> Regarding the documentation, should we explicitly explain the
> relationship between 'pause' and sample_interval in the documentation?
> That way, users can adjust the sample_interval value when using pause
> feature based on their specific use case.

I think that is too much detail for normal users, unless we find a problem from
the lack of the documentation.


Thanks,
SJ

[...]
