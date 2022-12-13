Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2711915B0
	for <damon@lists.linux.dev>; Tue, 13 Dec 2022 01:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BCAC433EF;
	Tue, 13 Dec 2022 01:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670896352;
	bh=JUFHz4G5BIAlnJM6ImqLTsfHZswsJfOF1/964nJvH/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjXHx894XlOK6zJbIPyoIeyLCh6k1UpwDBgP+ZsPaQLlqSy/kK003WUEVvl6QaqY6
	 4x02NlRCc/MmEuYj3+No43znqYGu7hVIrwW5xP7a/KuPf76OmsmSddDMlAdq6GAetw
	 H6DA/hhyXWaHDCNvt3jAD1DiqvrbaKtHen2azV+WOAc65QQPPH7JPdNYSwdQNBMAAa
	 OmscaRevzmmhh9XFtVXOuJ6rO90bewwNKUnsX5HuZBaBQ/d+3d3HayLqCTF4cR318/
	 H7vOyVVaZF1m7jJEPpnjdgbaEdIEDSeG1saWvkDMizTElU61jPkC5xYLCneQ4/cpS1
	 DzgarKsSQU/Hw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Tue, 13 Dec 2022 01:52:30 +0000
Message-Id: <20221213015230.3010-1-sj@kernel.org>
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

Hello,

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

This is a reminder for the next instance of the chat series.  Next instance
will be 2022-12-13 (Tue) 09:30 PST.  You can show proposed agendas for the
chat, or propose your own using the above Google doc.

According to the original scheduling, the one after next instance would be
2022-12-26.  Because the day is during the holiday season, I've canceled it.
So, the tomorrow one will be the last instance of this chat series for 2022.
Hope to meet some of you :)


Thanks,
SJ
