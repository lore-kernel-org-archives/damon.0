Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562001E98EF;
	Thu, 23 Apr 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906807; cv=none; b=exT5yZf0nRYS3dfHd8fKMot83WwBJotR6s2bYzMBbHRpjZVDK11FJRtINXps4h4S4gfZZI+zeQGQu49BWiRtUgW8g/lOYhjNm9+zww7xhLay0kC71NOamvtPajNtEzl2WJDNe7Dzlsh8KI2GapqmjvSwHPvDlaIUYugLqbmDI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906807; c=relaxed/simple;
	bh=9PlMEv0oWcsxNV7gLe9VCQFtma4kLf2XofnBhTskP5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSqTAnkgknkmuG5D/WlexLdOTW07Qaziiymn6fJmuC4w32SerVPxIAeReC24aQ4h9Ehe76R4UgHevKkqRlnd6EyVqUzI6JoVcoKaLnB3uSQLSKaL0vkXFwQ6RyVPQYVoDlu1dtab/wp1jC13yxrNXPNR0VzUN6Io/CXUDSERPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxvJ3rFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxvJ3rFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DF5C19425;
	Thu, 23 Apr 2026 01:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776906807;
	bh=9PlMEv0oWcsxNV7gLe9VCQFtma4kLf2XofnBhTskP5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=fxvJ3rFpRZEP/uYy2ouXLhPPyRpvamrDwiryvCxHFlVTyR9GhOo6MnAhVqkMLH39X
	 JjIvph9JqkPz1CgqOj4NjJtTO/MDJLHZPGIRwx8Pyc4QB6T61t6T1SQPJk3yMtaj5u
	 GqzxoJ0GL+Dfni1BJSrzHOl/Z6z62ma0xS91taABFe9kImfNUBGZEy9o+E7WPyhkMV
	 jYt6LLMkntzrHM5RvDKn6EdoFF3Jq0s/fcwRgfIXMUsbBjY4i8fkD5EQcF3HWje/V3
	 EQ8b/4yTpuH8whviWcUH00VcgDYyS2TYXIemc085u8Nn1IGm1X1P29JMs+flwAj0eD
	 jWZa63uIUe0GQ==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-04-27
Date: Wed, 22 Apr 2026 18:13:18 -0700
Message-ID: <20260423011319.32122-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
for the week of 2026-04-27.

As usual, we have two time slots for meetings in the week.

Next time slots including six virtual-only ones are as below.

2026-04-27 (Mon) 18:00 PT (not yet reserved)
2026-04-29 (Wed) 09:30 PT (not yet reserved)
2026-05-11 (Mon) 18:00 PT (not yet reserved)
2026-05-13 (Wed) 09:30 PT (not yet reserved)
2026-05-25 (Mon) 18:00 PT (not yet reserved)
2026-05-27 (Wed) 09:30 PT (not yet reserved)

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
