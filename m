Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE015665C;
	Fri,  5 Dec 2025 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964514; cv=none; b=o4qziEBWn92ioBRr4MIDJzINavO1DsscGRNezvVe+st6y5mZt7BVQEXFRWbdMs+DHuecRqeBAZkCBdRot1AzRgErKeDQ28dH464xfybgXHqiBiYHcZGg8oAzZvS9Pno0PH0vEDJCyw1ECRTzcsBA9owxLhEuGkPOlAlyqSZjicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964514; c=relaxed/simple;
	bh=szrqBFkV65UASaZTapgs6pxmZf/jre4C39Tr9u9FjCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoIe/6JAvPLF+SNCuvNps8+HeN5CzDTa9hgdWhFw8bayfvvJqyxOoXTf2DvxBjvG8u6+4rjvw7fETl/9Grp+GWUts53FVqojcb0MHh+8wjLPD459D5elFBz64OiXgkYu6A7kqFR1t0Er9UBeMgsp/jaQnHGpKOVm+7ouGvfjFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8qZi7RQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8qZi7RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7376CC4CEF1;
	Fri,  5 Dec 2025 19:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764964511;
	bh=szrqBFkV65UASaZTapgs6pxmZf/jre4C39Tr9u9FjCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8qZi7RQeDHav5qK/QGaV9WJKEQQ4gIWQbY+sdvde5Nnv78crrn9K37SIiKpoxxkc
	 nC9v9kj3+XQ5H1lIJBOpnpjux4Pory5Pwz0j/Pi3+luC2znyUh5ipyVZdmmdBA27KL
	 fyYbSCJCTyahw2t5uF7SipEwi4E99XMrHAA3foQl6XQEyGUsR4wZgyXY6zFjbk40Jh
	 GBOf/uc9NmaW/e5d3HOX1JrY+X8pnY9p5aoSB59x2dDo0JuH1q21QW8yaLCMBesar0
	 4FR1ASqNSRycAjdkRo/bLq/IXZZ0Ew1oGK2Hje7Y1C1txmccJVGxHrxDsdLeUb0NgM
	 foNXR4CjJU+ew==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-12-06
Date: Fri,  5 Dec 2025 11:55:08 -0800
Message-ID: <20251205195509.76051-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205193540.75695-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Dec 2025 11:35:39 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
> (https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
> for the week of 2025-12-08.
> 
> On the week of 2025-12-08, I will travel Japan for OSSummit Japan and LPC.
> Attending video calls on the usual Pacific time-optimized time slot during the
> week will be challenging for me.  So let's do the chats for the week without
> the pre-booked time slots, but as an unlimited and possibly in-person version.
> That is, let's make it can happen at any time and any place (not only Google
> Meet but also somewhere in Tokyo, Japan) as long as we can.
> 
> If you have any DAMON topic that you want to discuss with me during the week,
> send an email to sj@kernel.org saying you have a topic to discuss, with
> when/where you want to meet.  Then we can further adjust our schedule.  If you
> also attend OSSummit Japan or LPC in person, you are also very welcome to just
> reach out to me in person at any time/place without making appointment.

For a case that you want to use the latter option (just reaching out on the
conference) but wondering when/where of the conference you can capture me. I
will have four sessions on the conferences, so before/after the talk near the
session rooms would be tood times and places.

You can get the time and place of the talks from below.

- OSS JP, 2025-12-08 (Mon): https://sched.co/29FmF
- LPC (specific purpose memory MC), 2025-12-11 (Thu):
  https://lpc.events/event/19/contributions/2066/
- LPC (observability MC), 2025-12-11 (Thu):
  https://lpc.events/event/19/contributions/2059/
- LPC (refereed track), 2025-12-12 (Fri):
  https://lpc.events/event/19/contributions/2075/


Thanks,
SJ

[...]
