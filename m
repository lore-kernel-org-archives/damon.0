Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAF7E
	for <damon@lists.linux.dev>; Tue,  1 Aug 2023 01:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02D7C433C8;
	Tue,  1 Aug 2023 01:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690852888;
	bh=gZq2C/GVYvLDKVT/9oQ/tc2BeAoPIrbCRPRE9OxNO4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKTpVTKNPWm3YmZ4N45FDecL3jt6iC7xcA3zIgHfxl2qY1ZuLctwB/5v24I+BkDix
	 DrsOcoKZ47EMHFx8gQnTiPUORhA9+HjzeIZjqTnc/dM9Huti5jf8T8DFGIj1gbnAg+
	 jQuQFzK8lls/wvHlXBr8jzmF+uKTNvCi259gf2xrnbJ8ZtnkUQDWUt3LHoY8TVW9Rx
	 T9uXk3bHTuiyr6nw20rFe6n+hqT85Ofo5WSZujuSMXiThy8Epfj0i1nRZJUYScc+xV
	 7F4GSJ2xnpGk6+wDwHH/++3m/u0E0bkwALc+JIckM89wdIGggVTw987W/lKimg4bcJ
	 YN4VOZC+W3RFQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Tue,  1 Aug 2023 01:21:26 +0000
Message-Id: <20230801012126.6249-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello community,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing

I'm gonna be out of office from mid of August to end of OSSummit Euro 2023[1],
partly for preparation of my OSSummit Euro talk[2].  For the reason, I will not
be able to schedule and attend the DAMON beer/coffee/tea meeting during the
time.  I will still be reachable, though I might be less responsive during the
period.

Also, looking forward to meet some of you who will attend the conference! :)

[1] https://events.linuxfoundation.org/open-source-summit-europe/
[2] https://sched.co/1OGf9


Thanks,
SJ
