Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9E3B52E6
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136227; cv=none; b=s2VrZCUGGWtC8fRiRSQT2o51Jmum9euzDf/gya7x2/ZsRaVBsIBhe99kpxwRQgeP8La41wj/kgtVS1dF7C1IsZb1G4XzxnXOo7qOZ9vCkOSIfDWIwjickHEbpOniDmauJJxUyIpu+Yl5cyM8HKX04f1UZ+Lq0sh1U7sqgqfHP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136227; c=relaxed/simple;
	bh=WaMGAqHxTgmKjROw91GzmxSK5RjU/k/jz2+aR/ZOF2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMQFZFo91t0pJC4EGgirEEvnoqI5QSZFEyzRsQQB1BXPVqa+OoyQLMnZv+XS/K2aXBguFkWcFNu5ehy3zbSSly1YPJULUohOiPZjcbB57b70n3x6YvYjCYFV/YLjaolmXrbL7wHZ6XvKleMnST8arVmInVgKDtlAyzjpyFVw7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKt9N9p0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKt9N9p0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84237c55ef9so2583497b3a.0
        for <damon@lists.linux.dev>; Mon, 22 Jun 2026 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136225; x=1782741025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JklLI1PzmutjaR/qD6MqKr8l8fd6E56tko0hJj8Zrho=;
        b=pKt9N9p0dLIyxOPO89o1LzHPxz7c688lZ8dxGnF6nFszAWrAlPvEm5+pJn1VisHjiX
         gCOPOXN/Fw7zrynbeK2YdLiCcwNokADW6lrn8ksrBdgpeczaiq42oMR+iy56+JNl0xjo
         y/WEINXUv9f2mT1Cd9S4uxHTlL1yEUoSd3zDPpy9ZZc5Q+ka1FGwfXFTVE626XNs/XGY
         bGh79lBnNfwdULDz9e065H+Q8bBnWM1oBIme73ymokC0TcLz9WemENxfDrkzQc7GngyV
         OvVXLbQD5W4ZE6GPxXeL8vdJGEdgfn8NE4szlBSzSbUTtB/Tk/w656XtKi4xuN9p+vGl
         W1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136225; x=1782741025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JklLI1PzmutjaR/qD6MqKr8l8fd6E56tko0hJj8Zrho=;
        b=JaSGDXgbZNJT0481Tc31GQdEHInazmlfbjiYj0OLa2TQYGPErv/M5sTot/kA44QLNO
         ns0BTY7SSSweQAYpEYZRuCzjqSV74SiYPxjG6azee43LbxGbFMXzlrPNTIoaOBMq7j/T
         zKEGz71yYyz34iy7IeNmOczqJpoF0tiloE/YursqYJSNinyvO2Ca8rhwc0bCCZUgcInC
         J3Nyb5kFCZgoU3yXa2XZDJg5VPb1KczICbkzGWW8JA4BF3Lk2/QG2j3SDUiS49b+0thk
         9ou3Fopd+MyP01t7yEs3cchId6+0aTg74esfbBcgOvT+NvUABKxpzPYnHx3XhG4CLngl
         EmrQ==
X-Gm-Message-State: AOJu0YzO2+OBVSArOBV2+TpBP7fmnix6n9KrW7rWNQ7MsLtiF1RRU9c3
	k0YYORCPIm7Rd6CuEWmb0LXbtK6pj8O0OYp8Z8ERUDjEH/WkHzKpr3k9PBbR+Q==
X-Gm-Gg: AfdE7cl7Y62VWAxGfPviKkUPVmKtMhihXFLMkwtxZVapQpLjPWLRUAiXbsmgyFRGzbr
	HgKpO8SfQ9gWcQFVl+WY0E4IxIcdWhyzqdopvR/2kKGi7Tf+JZfDfg+hYv6vCcclJhcUiCuY3V5
	gE0ahxCuYo+Uq0HmRZ75id95/GcVEESd5jedU3QEDk2yv1uRMY4OyDNv1R891UvwbGIP0fzAO+j
	raB2bnMK6wFHiUDlkh/Br8h5yJZ8HV51O7tqCtsz7iT17YpFrUO0LD4FZu0Hpb8UnsJ+fp+O8ar
	QvwN37izkRXyUMVVo4yjH5lmdi8jvQMFU1p+64JJWUUnkNjtq/NjaLz1toG9GFmaLZxOz7NIM3N
	LqXTZh+NRtlJZoZYpsIBGBU1Bkj5WhO2QLwh+PkGA/RgXDuQLaQWwlHyWIGvXKQLq/AIEfrCyzi
	49nDiGSIy6N4qFma9IPK8hlmSefg==
X-Received: by 2002:a05:6a00:cc1:b0:845:344f:ef1a with SMTP id d2e1a72fcca58-84556072698mr14576719b3a.15.1782136224869;
        Mon, 22 Jun 2026 06:50:24 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:47f:2522:acac:f810])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea146asm7606177b3a.43.2026.06.22.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:50:24 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	ravis.opensrc@gmail.com,
	akinobu.mita@gmail.com
Subject: [RFC PATCH 2/2] damo: add --perf_event option
Date: Mon, 22 Jun 2026 22:49:33 +0900
Message-ID: <20260622134933.35773-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622134933.35773-1-akinobu.mita@gmail.com>
References: <20260622134933.35773-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The argument for the newly added --perf_event can be the same PMU event as
the 'perf record' -e option.

The appropriate PMU event can be found in the following way:

```
$ sudo perf mem record sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.030 MB perf.data (12 samples) ]
$ sudo perf evlist
cpu/mem-loads,ldlat=30/P
cpu/mem-stores/P
```

In this case, you can set up perf events by starting damo as follows:

```
$ sudo damo start \
    --perf_event "cpu/mem-loads,ldlat=30,freq=5000/P" \
    --perf_event "cpu/mem-stores,freq=5000/P" \
    ...
```

In this example, the sampling frequency is also specified by the common
parameter 'freq'.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 src/_damo_fmt_str.py |   5 ++
 src/_damon.py        | 106 +++++++++++++++++++++++++++++++++-
 src/_damon_args.py   |  79 +++++++++++++++++++++++--
 src/_damon_sysfs.py  | 133 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 314 insertions(+), 9 deletions(-)

diff --git a/src/_damo_fmt_str.py b/src/_damo_fmt_str.py
index 6c51e24a..d93d5ba8 100644
--- a/src/_damo_fmt_str.py
+++ b/src/_damo_fmt_str.py
@@ -257,6 +257,11 @@ def text_to_nr(txt):
         pass
     return float(new_txt)
 
+def text_to_hex(txt):
+    if type(txt) == int:
+        return txt
+    return int(txt, 16)
+
 def try_common_input(txt, min_val=0, max_val=ulong_max):
     'return success and number'
     if txt == 'min':
diff --git a/src/_damon.py b/src/_damon.py
index 8cfc61e3..52653fc5 100644
--- a/src/_damon.py
+++ b/src/_damon.py
@@ -261,6 +261,93 @@ class DamonNrRegionsRange:
             ('max', _damo_fmt_str.format_nr(self.maximum, raw)),
             ])
 
+class DamonPerfEvent:
+    attr_type = None
+    config = None
+    config1 = None
+    config2 = None
+    freq = None
+    sample_period = None
+    sample_freq = None
+    sample_phys_addr = None
+    sample_weight_struct = None
+    exclude_kernel = None
+    exclude_hv = None
+    precise_ip = None
+    wakeup_events = None
+
+    def __init__(self, attr_type='0x0', config='0x0', config1='0x0',
+                 config2='0x0', freq=1, sample_period=0, sample_freq=0,
+                 sample_phys_addr=0, sample_weight_struct=0, exclude_kernel=0,
+                 exclude_hv=0, precise_ip=2, wakeup_events=0):
+        self.attr_type = _damo_fmt_str.text_to_hex(attr_type)
+        self.config = _damo_fmt_str.text_to_hex(config)
+        self.config1 = _damo_fmt_str.text_to_hex(config1)
+        self.config2 = _damo_fmt_str.text_to_hex(config2)
+        self.freq = _damo_fmt_str.text_to_nr(freq)
+        self.sample_period = _damo_fmt_str.text_to_nr(sample_period)
+        self.sample_freq = _damo_fmt_str.text_to_nr(sample_freq)
+        self.sample_phys_addr = _damo_fmt_str.text_to_nr(sample_phys_addr)
+        self.sample_weight_struct = _damo_fmt_str.text_to_nr(sample_weight_struct)
+        self.exclude_kernel = _damo_fmt_str.text_to_nr(exclude_kernel)
+        self.exclude_hv = _damo_fmt_str.text_to_nr(exclude_hv)
+        self.precise_ip = _damo_fmt_str.text_to_nr(precise_ip)
+        self.wakeup_events = _damo_fmt_str.text_to_nr(wakeup_events)
+
+    def to_str(self, raw):
+        lines = []
+        lines.append('type: %#x' % self.attr_type)
+        lines.append('config: [%#x, %#x, %#x]' % self.config, self.config1, self.config2)
+        lines.append('freq: %s' % _damo_fmt_str.format_nr(self.freq, raw))
+        lines.append('sample_period: %s' % _damo_fmt_str.format_nr(self.sample_period, raw))
+        lines.append('sample_freq: %s' % _damo_fmt_str.format_nr(self.sample_freq, raw))
+        lines.append('sample_phys_addr: %s' % _damo_fmt_str.format_nr(self.sample_phys_addr, raw))
+        lines.append('sample_weight_struct: %s' % _damo_fmt_str.format_nr(self.sample_weight_struct, raw))
+        lines.append('exclude_kernel: %s' % _damo_fmt_str.format_nr(self.exclude_kernel, raw))
+        lines.append('exclude_hv: %s' % _damo_fmt_str.format_nr(self.exclude_hv, raw))
+        lines.append('precise_ip: %s' % _damo_fmt_str.format_nr(self.precise_ip, raw))
+        lines.append('wakeup_events: %s' % _damo_fmt_str.format_nr(self.wakeup_events, raw))
+        return '\n'.join(lines)
+
+    def __str__(self):
+        return self.to_str(False)
+
+    def __eq__(self, other):
+        return type(self) == type(other) and '%s' % self == '%s' % other
+
+    @classmethod
+    def from_kvpairs(cls, kvpairs):
+        return DamonPerfEvent(attr_type=kvpairs['type'],
+                              config=kvpairs['config'],
+                              config1=kvpairs['config1'],
+                              config2=kvpairs['config2'],
+                              freq=kvpairs['freq'],
+                              sample_period=kvpairs['sample_period'],
+                              sample_freq=kvpairs['sample_freq'],
+                              sample_phys_addr=kvpairs['sample_phys_addr'],
+                              sample_weight_struct=kvpairs['sample_weight_struct'],
+                              exclude_kernel=kvpairs['exclude_kernel'],
+                              exclude_hv=kvpairs['exclude_hv'],
+                              precise_ip=kvpairs['precise_ip'],
+                              wakeup_events=kvpairs['wakeup_events'])
+
+    def to_kvpairs(self, raw=False):
+        return collections.OrderedDict([
+            ('type', '%#x' % self.attr_type),
+            ('config', '%#x' % self.config),
+            ('config1', '%#x' % self.config1),
+            ('config2', '%#x' % self.config2),
+            ('freq', _damo_fmt_str.format_nr(self.freq, raw)),
+            ('sample_period', _damo_fmt_str.format_nr(self.sample_period, raw)),
+            ('sample_freq', _damo_fmt_str.format_nr(self.sample_freq, raw)),
+            ('sample_phys_addr', _damo_fmt_str.format_nr(self.sample_phys_addr, raw)),
+            ('sample_weight_struct', _damo_fmt_str.format_nr(self.sample_weight_struct, raw)),
+            ('exclude_kernel', _damo_fmt_str.format_nr(self.exclude_kernel, raw)),
+            ('exclude_hv', _damo_fmt_str.format_nr(self.exclude_hv, raw)),
+            ('precise_ip', _damo_fmt_str.format_nr(self.precise_ip, raw)),
+            ('wakeup_events', _damo_fmt_str.format_nr(self.wakeup_events, raw)),
+            ])
+
 damon_filter_type_cpumask = 'cpumask'
 damon_filter_type_threads = 'threads'
 damon_filter_type_write = 'write'
@@ -359,14 +446,18 @@ class DamonPrimitivesEnabled:
 class DamonSampleControl:
     primitives_enabled = None
     sample_filters = None
+    perf_events = None
 
-    def __init__(self, primitives_enabled=None, sample_filters=None):
+    def __init__(self, primitives_enabled=None, sample_filters=None, perf_events=None):
         if primitives_enabled is None:
             primitives_enabled = DamonPrimitivesEnabled()
         if sample_filters is None:
             sample_filters = []
+        if perf_events is None:
+            perf_events = []
         self.primitives_enabled = primitives_enabled
         self.sample_filters = sample_filters
+        self.perf_events = perf_events
 
     def to_str(self, raw):
         lines = [
@@ -375,6 +466,10 @@ class DamonSampleControl:
             lines.append('Filters')
             for filter in self.sample_filters:
                 lines.append('- %s' % filter.to_str(raw))
+        if len(self.perf_events) > 0:
+            lines.append('PerfEvents')
+            for perf_event in self.perf_events:
+                lines.append('- %s' % perf_event.to_str(raw))
         return '\n'.join(lines)
 
     def __str__(self):
@@ -383,7 +478,8 @@ class DamonSampleControl:
     def __eq__(self, other):
         return type(self) == type(other) and \
                 self.primitives_enabled == other.primitives_enabled and \
-                self.sample_filters == other.sample_filters
+                self.sample_filters == other.sample_filters and \
+                self.perf_events == other.perf_events
 
     @classmethod
     def from_kvpairs(cls, kv):
@@ -391,13 +487,17 @@ class DamonSampleControl:
                 primitives_enabled=DamonPrimitivesEnabled.from_kvpairs(
                     kv['primitives_enabled']),
                 sample_filters=[DamonSampleFilter.from_kvpairs(kvpairs)
-                                for kvpairs in kv['sample_filters']])
+                                for kvpairs in kv['sample_filters']],
+                perf_events=[DamonPerfEvent.from_kvpairs(p)
+                                for p in kv['perf_events']])
 
     def to_kvpairs(self, raw=False):
         return collections.OrderedDict([
             ('primitives_enabled', self.primitives_enabled.to_kvpairs(raw)),
             ('sample_filters', [
                 f.to_kvpairs(raw) for f in self.sample_filters]),
+            ('perf_events', [
+                p.to_kvpairs(raw) for p in self.perf_events])
             ])
 
 unit_percent = 'percent'
diff --git a/src/_damon_args.py b/src/_damon_args.py
index c85e99be..8a652058 100644
--- a/src/_damon_args.py
+++ b/src/_damon_args.py
@@ -18,6 +18,12 @@ except ModuleNotFoundError:
     # properly.
     pass
 
+try:
+    import perf
+except:
+    print('Please install perf.cpython-*-linux-gnu.so', file=sys.stderr)
+    raise
+
 import _damo_subproc
 import _damo_sysinfo
 import _damon
@@ -110,6 +116,33 @@ def damon_nr_regions_range_for(args_range, args_minr, args_maxr):
     override_vals(nr_range, [args_minr, args_maxr])
     return _damon.DamonNrRegionsRange(*nr_range)
 
+def damon_perf_events_for(args_perf_event, args_ops):
+    events = []
+    if args_perf_event:
+        for event in args_perf_event:
+            sample_phys_addr = 1 if args_ops == 'paddr' else 0
+            evlist = perf.parse_events(event[0])
+            evlist.config()
+            if len(evlist) != 1:
+                raise Exception('%s event is ambiguous' % event[0])
+            evsel = evlist[0]
+            sample_period = evsel.sample_period if evsel.freq == 0 else 0
+            sample_freq = evsel.sample_period if evsel.freq == 1 else 0
+            events.append(_damon.DamonPerfEvent(
+                attr_type=evsel.type,
+                config=evsel.config,
+                config1=evsel.config1,
+                config2=evsel.config2,
+                freq=evsel.freq,
+                sample_period=sample_period,
+                sample_freq=sample_freq,
+                sample_phys_addr=sample_phys_addr,
+                exclude_kernel=evsel.exclude_kernel,
+                exclude_hv=evsel.exclude_hv,
+                precise_ip=evsel.precise_ip,
+                ))
+    return events
+
 def schemes_option_to_damos(schemes):
     if os.path.isfile(schemes):
         with open(schemes, 'r') as f:
@@ -540,10 +573,14 @@ def sample_control_to_ops_attrs_args(args, idx):
         return '--sample_primitives of %s is not supported for now' % \
                 sample_primitives
 
-def build_sample_control_ops_attrs(args, idx):
+def build_sample_control_ops_attrs(args, idx, args_perf_event):
     '''
     Returns DamonSampleControl, OpsAttrs, and an error
     '''
+    try:
+        perf_events = damon_perf_events_for(args_perf_event, args.ops[idx])
+    except Exception as e:
+        return None, None, 'invalid perf_event arguments (%s)' % e
     err = sample_control_to_ops_attrs_args(args, idx)
     if err is not None:
         return None, None, err
@@ -595,10 +632,11 @@ def build_sample_control_ops_attrs(args, idx):
             allow=True, tid_arr=tids))
     sample_control = _damon.DamonSampleControl(
             primitives_enabled=primitives_enabled,
-            sample_filters=sample_filters)
+            sample_filters=sample_filters,
+            perf_events=perf_events)
     return sample_control, None, None
 
-def damon_ctx_for(args, idx):
+def damon_ctx_for(args, idx, args_perf_event):
     if args.ops[idx] is None:
         if args.target_pid[idx] is None:
             args.ops[idx] = 'paddr'
@@ -620,7 +658,7 @@ def damon_ctx_for(args, idx):
     except Exception as e:
         return None, 'invalid nr_regions arguments (%s)' % e
     ops = args.ops[idx]
-    sample_control, ops_attrs, err = build_sample_control_ops_attrs(args, idx)
+    sample_control, ops_attrs, err = build_sample_control_ops_attrs(args, idx, args_perf_event)
     if err is not None:
         return None, 'exp_ops_* handling fail (%s)' % err
     pause = False
@@ -836,12 +874,35 @@ def gen_assign_probes(ctxs, args):
         probe_idx += nr
     return None
 
+def gen_assign_perf_events(args_perf_events, args):
+    nr_ctxs = get_nr_ctxs(args)
+    if args.nr_perf_events is None:
+        if nr_ctxs != 1 and len(args.perf_event) > 0:
+            return '--nr_perf_events is required'
+        args.nr_perf_events = [len(args.perf_event)]
+        args.nr_perf_events += [0] * (nr_ctxs - 1)
+    if sum(args.nr_perf_events) != len(args.perf_event):
+        return '--nr_perf_events mismatches number of perf_events (%d != %d)' % (
+                sum(args.nr_perf_events), len(args.perf_event))
+    if len(args.nr_perf_events) != nr_ctxs:
+        return '--nr_perf_events mismatches number of contexts (%d != %d)' % (
+                len(args.nr_perf_events), nr_ctxs)
+    perf_event_idx = 0
+    for nr in args.nr_perf_events:
+        args_perf_events.append(args.perf_event[perf_event_idx:perf_event_idx + nr])
+        perf_event_idx += nr
+    return None
+
 def damon_ctxs_for(args):
     fillup_none_ctx_args(args)
     fillup_none_target_args(args)
+    args_perf_events = []
+    err = gen_assign_perf_events(args_perf_events, args)
+    if err is not None:
+        return None, err
     ctxs = []
     for idx in range(get_nr_ctxs(args)):
-        ctx, err = damon_ctx_for(args, idx)
+        ctx, err = damon_ctx_for(args, idx, args_perf_events[idx])
         if err is not None:
             return None, err
         ctxs.append(ctx)
@@ -1368,6 +1429,14 @@ def set_monitoring_attrs_argparser(parser, hide_help=False):
                         choices=['page_table', 'page_fault'], nargs='+',
                         help='access sampling primitives to use'
                         if not hide_help else argparse.SUPPRESS)
+    parser.add_argument('--perf_event', nargs='+',
+                        metavar=('<event>'),
+                        default=[], action='append',
+                        help='monitoring perf_event'
+                        if not hide_help else argparse.SUPPRESS)
+    parser.add_argument('--nr_perf_events', type=int, metavar='<number>', nargs='+',
+                        help='number of perf events for each context (in order)'
+                        if not hide_help else argparse.SUPPRESS)
 
 def set_monitoring_damos_common_args(parser, hide_help=False):
     parser.add_argument('--ops', choices=['vaddr', 'paddr', 'fvaddr'],
diff --git a/src/_damon_sysfs.py b/src/_damon_sysfs.py
index 387e6f96..ccff3e30 100644
--- a/src/_damon_sysfs.py
+++ b/src/_damon_sysfs.py
@@ -616,6 +616,102 @@ def write_probes_dir(dir_path, probes):
             return err
     return None
 
+def write_perf_event_dir(dir_path, perf_event):
+    err = _damo_fs.write_file(
+            os.path.join(dir_path, 'type'),
+            '%#x' % perf_event.attr_type)
+    if err is not None:
+        return err
+
+    err = _damo_fs.write_file(
+            os.path.join(dir_path, 'config'),
+            '%#x' % perf_event.config)
+    if err is not None:
+        return err
+
+    err = _damo_fs.write_file(
+            os.path.join(dir_path, 'config1'),
+            '%#x' % perf_event.config1)
+    if err is not None:
+        return err
+
+    err = _damo_fs.write_file(
+            os.path.join(dir_path, 'config2'),
+            '%#x' % perf_event.config2)
+    if err is not None:
+        return err
+
+    freq_path = os.path.join(dir_path, 'freq')
+    if os.path.isfile(freq_path):
+        err = _damo_fs.write_file(freq_path, '%d' % perf_event.freq)
+        if err is not None:
+            return err
+
+    sample_period_path = os.path.join(dir_path, 'sample_period')
+    if os.path.isfile(sample_period_path):
+        err = _damo_fs.write_file(sample_period_path,
+            '%d' % perf_event.sample_period)
+        if err is not None:
+            return err
+
+    err = _damo_fs.write_file(
+            os.path.join(dir_path, 'sample_freq'),
+            '%d' % perf_event.sample_freq)
+    if err is not None:
+        return err
+
+    err = _damo_fs.write_file(
+            os.path.join(dir_path, 'sample_phys_addr'),
+            '%d' % perf_event.sample_phys_addr)
+    if err is not None:
+        return err
+
+    sample_weight_struct_path = os.path.join(dir_path, 'sample_weight_struct')
+    if os.path.isfile(sample_weight_struct_path):
+        err = _damo_fs.write_file(sample_weight_struct_path,
+            '%d' % perf_event.sample_weight_struct)
+        if err is not None:
+            return err
+
+    exclude_kernel_path = os.path.join(dir_path, 'exclude_kernel')
+    if os.path.isfile(exclude_kernel_path):
+        err = _damo_fs.write_file(exclude_kernel_path,
+            '%d' % perf_event.exclude_kernel)
+        if err is not None:
+            return err
+
+    exclude_hv_path = os.path.join(dir_path, 'exclude_hv')
+    if os.path.isfile(exclude_hv_path):
+        err = _damo_fs.write_file(exclude_hv_path,
+            '%d' % perf_event.exclude_hv)
+        if err is not None:
+            return err
+
+    precise_ip_path = os.path.join(dir_path, 'precise_ip')
+    if os.path.isfile(precise_ip_path):
+        err = _damo_fs.write_file(precise_ip_path,
+            '%d' % perf_event.precise_ip)
+        if err is not None:
+            return err
+
+    wakeup_events_path = os.path.join(dir_path, 'wakeup_events')
+    if os.path.isfile(wakeup_events_path):
+        err = _damo_fs.write_file(wakeup_events_path,
+            '%d' % perf_event.wakeup_events)
+        if err is not None:
+            return err
+
+def write_perf_events_dir(dir_path, perf_events):
+    err = ensure_nr_file_for(os.path.join(dir_path, 'nr_perf_events'), perf_events)
+    if err is not None:
+        return err
+
+    for idx, perf_event in enumerate(perf_events):
+        err = write_perf_event_dir(os.path.join(dir_path, '%d' % idx), perf_event)
+        if err is not None:
+            return err
+    return None
+
 def write_sample_filter_dir(dir_path, sample_filter):
     err = _damo_fs.write_file(
             os.path.join(dir_path, 'type'), sample_filter.filter_type)
@@ -677,6 +773,12 @@ def write_sample_control_dir(dir_path, sample_control):
             'Y' if sample_control.primitives_enabled.page_fault else 'N')
     if err is not None:
         return err
+
+    err = write_perf_events_dir(
+            os.path.join(dir_path, 'perf_events'), sample_control.perf_events)
+    if err is not None:
+        return err
+
     return write_sample_filters_dir(
             os.path.join(dir_path, 'filters'), sample_control.sample_filters)
 
@@ -1094,9 +1196,15 @@ def files_content_to_sample_control(files_content):
     primitives_enabled = _damon.DamonPrimitivesEnabled(
             page_table=page_table, page_fault=page_fault)
     sample_filters = files_content_to_sample_filters(files_content['filters'])
+
+    perf_events_content = files_content['perf_events']
+    perf_events = [files_content_to_perf_event(content)
+            for content in numbered_dirs_content(
+                perf_events_content, 'nr_perf_events')]
     return _damon.DamonSampleControl(
             primitives_enabled=primitives_enabled,
-            sample_filters=sample_filters)
+            sample_filters=sample_filters,
+            perf_events=perf_events)
 
 def files_content_to_ops_attrs(files_content):
     use_reports = files_content['use_reports'].strip()
@@ -1106,6 +1214,29 @@ def files_content_to_ops_attrs(files_content):
     return _damon.OpsAttrs(use_reports=use_reports, write_only=write_only,
                            cpus=cpus, tids=tids)
 
+def files_content_to_perf_event(files_content):
+    freq = int(files_content['freq']) if 'freq' in files_content else 1
+    sample_period = int(files_content['sample_period']) if 'sample_period' in files_content else 0
+    sample_weight_struct = int(files_content['sample_weight_struct']) if 'sample_weight_struct' in files_content else 0
+    exclude_kernel = int(files_content['exclude_kernel']) if 'exclude_kernel' in files_content else 0
+    exclude_hv = int(files_content['exclude_hv']) if 'exclude_hv' in files_content else 0
+    precise_ip = int(files_content['precise_ip']) if 'precise_ip' in files_content else 2
+    wakeup_events = int(files_content['wakeup_events']) if 'wakeup_events' in files_content else 0
+    return _damon.DamonPerfEvent(
+            attr_type=int(files_content['type'], 16),
+            config=int(files_content['config'], 16),
+            config1=int(files_content['config1'], 16),
+            config2=int(files_content['config2'], 16),
+            freq=freq,
+            sample_period=sample_period,
+            sample_freq=int(files_content['sample_freq']),
+            sample_phys_addr=int(files_content['sample_phys_addr']),
+            sample_weight_struct=sample_weight_struct,
+            exclude_kernel=exclude_kernel,
+            exclude_hv=exclude_hv,
+            precise_ip=precise_ip,
+            wakeup_events=wakeup_events)
+
 def files_content_to_context(files_content):
     mon_attrs_content = files_content['monitoring_attrs']
     intervals_content = mon_attrs_content['intervals']
-- 
2.43.0

