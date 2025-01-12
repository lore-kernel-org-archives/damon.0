Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262F1BEF67;
	Sun, 12 Jan 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736702631; cv=none; b=kNrpdTTc+UNxD1E/tkFkRYxoTBlPhg0koAO2xBk3fhIqNXL9wZkqdqznAbh3ZKlMsc4nDZGkoGlBzeqxm3O3OTPcjJyNnwnke6ApfTF7gO6WDer7yzJBfPhrST7BZm8zF+iSHmNsiGT9MhzGW0ysF+s12QpsEAlqRFByl2LlqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736702631; c=relaxed/simple;
	bh=eT2WTPswumgEFJ/7myLZ9yvc5/EP90Tu640IB+E+zvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M6iyzgDLtYckIs8/mZBtiz1xqe+XRVo99scp6r1ZrAa6sWrmRRn7e/447DQOUKJl0sBgZoIJlpaYlgP4rnaH/SA42gSpNJldJ9o6rGbmIiArHIXWmuwXGa85Og/XITZgN3JwTntMiCIduD9jVLxQZIk7RvszveczCYzEjKZr3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgqGZTC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgqGZTC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE23C4CEDF;
	Sun, 12 Jan 2025 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736702630;
	bh=eT2WTPswumgEFJ/7myLZ9yvc5/EP90Tu640IB+E+zvU=;
	h=From:To:Cc:Subject:Date:From;
	b=cgqGZTC5FYqxILiwJAeK2BW0wKiwvmmOGWj8b8Z6RLYyrhECHWvUfEzzXbFwttwRi
	 176OqO7ousnq+DRbqJylwxGzW9PHuKroynQbxTkkTe5WIXmNZZ0hRTmhuI11SrLyE7
	 g3x3zCeGczJpjVGOj3wmX50neGVNk9SmaAdUxjntvueU9fRpptlt232y3vmVyrHBrN
	 p5cNK9TPWuhw47mTQTwmoS/PQq0RHQI44G3RwcSiBAI8MEP4fb31wT3m92hFDONdAI
	 2vZ2Reyqblg+LmN5eS9bK6qb9UbXuaE0OEVUjvF7y7LjFy86fh7DPn7sKQ9ioha473
	 WtePqYMA0Q88w==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-01-13
Date: Sun, 12 Jan 2025 09:23:44 -0800
Message-Id: <20250112172344.23391-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2025-01-13.

We will have the two meetings in the week as usual.

Any-topic discussions
---------------------

Next three time slots for any topic (no reservation is required) are scheduled
as below:

- 2025-01-13 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-01-29 (Wed) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2025-02-10 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2025-01-15 (Wed) 09:30 PT (not yet reserved)
- 2025-01-27 (Mon) 18:00 PT (not yet reserved)
- 2025-02-12 (Wed) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available on demands.

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
