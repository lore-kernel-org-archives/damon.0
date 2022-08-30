Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0E610B
	for <damon@lists.linux.dev>; Tue, 30 Aug 2022 21:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F714C433D6;
	Tue, 30 Aug 2022 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661896470;
	bh=xHHSsqyXtfFvtSuP9BsYTsHB7//jxKQSRPJ0XIR/rcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QW4MP+uCCe+jxwujxCTLVp9OODtpenlMFFt13R2rqldBzpm/zSFvCjtF41oQsw3oW
	 V0mCDN8RhUzcZVFEZvADNLSs27HZ9ruSusM+xQxrDh8hknRrFpclOaVguZLa50Pkpl
	 FiL72kj0okVnzMMZUQ0GBwF9ICnchkA1ubWkBM7ilcScQSv0oVNZCWxIigDCvvysmJ
	 BsJH4dmlSeiUkWX6p+Q4JMoB5D99Y2PsMTMLpUazjFtKUDjZzOOfo1HZtlRPPCMIZ7
	 nLvHWeO5Y20RRws2zDFMxNjfP3zb4aOPV0TfH0jzEv+sb7A57DmcEMGUTUsienZkTi
	 xr9G+dq+mjM9w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Tue, 30 Aug 2022 21:54:28 +0000
Message-Id: <20220830215428.84567-1-sj@kernel.org>
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
> 
> First instance: 2022-08-15 18:00 PDT
> Second instance: 2022-08-30 09:00 PDT

According to the bi-weekly schedule, the third instance of this meeting series
should be scheduled to 2022-09-12 18:00 PDT.  It means it will conflict with
LPC'22[1].  For the reason, I'd like to reserve a session in the BoF trakc of
the conference, and do an _in-persion_ DAMON community meeting in the session.
The session could also include some followup QnA/discussions of the kernel
summit DAMON talk[2].

I just submitted the BoF proposal asking it to be scheduled after the kernel
summit DAMON talk.  I will provide further update once I get the feedback from
the committee.  Hope it to be accepted!

[1] https://lpc.events/
[2] https://lpc.events/event/16/contributions/1224/


Thanks,
SJ

[...]
