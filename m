Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC84322A
	for <damon@lists.linux.dev>; Tue, 24 Jan 2023 23:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED762C433EF;
	Tue, 24 Jan 2023 23:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674601610;
	bh=s7pIW0jia0g5VIFzcKgT/jLZ3jSOURjQa383hJ8aYqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fg1YSiGUjN1zndovtoikiu0vqfEKGhRoqrNvGkbdoMwNlVXslB0X9fhYdmjB060pP
	 ucdwamaTozqkicBefjY1B865QF7EJ3BE+wIe0dao1RUWbnAb7UxO8mldV739t5HlwX
	 SyHqp1ltDgVhntqGkVlqwkURt4ywFhFKyvDu6lOwFtwREiXGa4wgYABxmU6gX59cID
	 VI/7V2kZxb6cDAVb+Fzh90sucX8kqvMFZGUhoX6HBiKhwouYhaGg1R9vIf1BHdYBzN
	 Hd/1YX1zGc/ua5r3MbE8sNG5bsR4Zt5TtVriUELvhyd/jMSfL6YIZi1WPphLSiMEPk
	 ZeBLuMbs+EWug==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Tue, 24 Jan 2023 23:06:48 +0000
Message-Id: <20230124230648.113669-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124014421.112436-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Jan 2023 01:44:21 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
> This is a reminder for the next instance of the chat series.  Next instance
> will be 2023-01-23 (Tue) 09:30 PST.  You can show proposed agendas for the
> chat, or propose your own using the above Google doc.  Looking forward to see
> you after about 15 hours for the first time in the new lunar year :)

If you tried to but couldn't join today meeting, that's not you or system's
fault but mine.  I was out of mind this morning due to some other urgent things
and therefore couldn't attend, sorry.

Let's have yet another one instance for next Tuesday morning (PST), so
2023-01-31 (Tue) 09:30 PST.


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
