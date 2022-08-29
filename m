Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03915C9B
	for <damon@lists.linux.dev>; Mon, 29 Aug 2022 20:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066ACC433C1;
	Mon, 29 Aug 2022 20:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661804126;
	bh=Nbea/MpIsOS17vINEQkh4l2v2+uDWkJzDxG0xnh2o5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/4hV7AWRTtHbNO2ydnNUYecEgv9FmaqLVdaWEoK7MgoD8HiwI8djou27rIzJWCJO
	 YzDBJmkCc50zWJktltsKhtFszG1L8EZzq8wWAhHZ2QSFyG0Q7GbJBUpwcxxdvpakeJ
	 qcJttQ11Iwvhc44cpKzVA5pZExQSOxZtrTMWsm5iDdTh2xQizEwqth32AqpBxhjhqZ
	 EKrs3COkiK15uhGUkSlZCb1nwregQFDBQDX3Z6cBp69q3jhqx4Zar98kslvNxkGOMK
	 sbEU7/T9RzJ2ylxaCAsWMdbN4UuoU7CXRs9w3Lprh+2FNeLNuMR7xmmdjvKI7lxJbT
	 YTLovUp7vNtMw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Mon, 29 Aug 2022 20:15:24 +0000
Message-Id: <20220829201524.52009-1-sj@kernel.org>
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

Hello all,


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

I just wanted to remind you the second instance of this chat series that
mentioned above will happen tomorrow morning (PDT).

Looking forward to see you there!


Thanks,
SJ

[...]
