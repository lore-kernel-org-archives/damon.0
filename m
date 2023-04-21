Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203C612D
	for <damon@lists.linux.dev>; Fri, 21 Apr 2023 19:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321FCC433D2;
	Fri, 21 Apr 2023 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682106328;
	bh=LVD0h2MtRQCLv9fYsPYzBh7vUpnhSB9kiT4aJ/lcBb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVmb4l0Cx3p3Qxeaw2ncyf3e8Kq1WYdBBcgoCJFvQXRLas9GNORBD0ly8URnWiULT
	 nSntdG0AnVlkUaZrsqQC2BgW2vAv75KaaRkh2Ll/+soE6XU1rrp7+Pj4Fv3MZ0RDg+
	 StOGYeyV5kxFTJjQ7DrWuGjE4z8hJNcTAKJ1AuwooLJdHQs9P6lbOrtrfGJVI+w78D
	 RDxywFgLb+qhbfBzHd/6E5964j7AIEo/8j6JDr2VqvX/z/3qmYkYxbSThgfXbMrHY+
	 J0q3V0on9kslCS4GaUdQD0RUVYvVRPOojH6AisJVOTE1nN5SQGFIhcFwmsRcHMpjUZ
	 kdxNdWAIeBfVA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Fri, 21 Apr 2023 19:45:26 +0000
Message-Id: <20230421194526.81736-1-sj@kernel.org>
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

The last instance was scheduled for Tuesday of this week, but I forgot the
schedule by my mistake.  Sorry if you wanted to join.  I therefore schedule
another instance for next Tuesday.  Please check the agenda doc for the updated
schedule.

Sorry again.


Thanks,
SJ
